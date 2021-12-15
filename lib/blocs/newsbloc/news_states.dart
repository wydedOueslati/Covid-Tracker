import 'package:covid19_news/models/article_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NewsStates extends Equatable {
  const NewsStates();

  @override
  List<Object> get props => [];
}

class NewsInitState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsLoadedState extends NewsStates {
  final List<ArticleModel> articleList;
  List<bool> isFav;

  NewsLoadedState({required this.articleList, required this.isFav});
}

class NewsErrorState extends NewsStates {
  final String errorMessage;
  NewsErrorState({required this.errorMessage});
}

// class ChangeFav extends NewsStates {
//   ChangeFav({required this.favIcon});
// }
