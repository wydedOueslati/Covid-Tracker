import 'package:covid19_news/blocs/newsbloc/news_bloc.dart';
import 'package:covid19_news/blocs/newsbloc/news_events.dart';
import 'package:covid19_news/blocs/newsbloc/news_states.dart';
import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/dash/newsui.dart';
import 'package:covid19_news/repositories/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 500.0,
              decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
              ),
              ),
              child: Center(child: _buildHeader()),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              child: BlocProvider<NewsBloc>(
              create: (context) => NewsBloc(
                initialState: NewsInitState(), newsRepositoty: NewsRepository()),
                child:NewsuiScreen(),
        ),
            ),
            ]
    )));
  }
}

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      'News',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}