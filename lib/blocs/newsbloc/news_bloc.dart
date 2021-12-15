import 'package:covid19_news/blocs/newsbloc/news_events.dart';
import 'package:covid19_news/blocs/newsbloc/news_states.dart';
import 'package:covid19_news/models/article_model.dart';
import 'package:covid19_news/repositories/news_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepository newsRepositoty;
  NewsBloc({required NewsStates initialState, required this.newsRepositoty})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<ArticleModel> _articleList = [];
        yield NewsLoadingState();
        _articleList = await newsRepositoty.fetchNews();
        yield NewsLoadedState(
            articleList: _articleList,
            isFav: List.filled(_articleList.length, false));
      } catch (e) {
        yield NewsErrorState(errorMessage: e.toString());
      }
    }
  }
}
