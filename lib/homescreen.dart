import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/dash/home.dart';
import 'package:covid19_news/dash/stats.dart';
import 'package:covid19_news/dash/symptoms.dart';
import 'package:covid19_news/dash/test.dart';
import 'package:covid19_news/dash/news.dart';
import 'package:covid19_news/utils/NavigationDrawerWidget.dart';
import 'package:covid19_news/utils/bottommenu.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int indexpage = 0;
  var pages = [
    HomePage(),
    StatsPage(),
    SymptomsPage(),
    NewsPage(),
    TestPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorPrimary,
        leading: Builder(builder: (context) => 
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer())),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined))
        ],
      ),
      body: pages[indexpage],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: white,
        color: colorPrimary,
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            color: white,
            size: 28,
          ),
          Icon(
            Icons.query_stats_outlined,
            color: white,
            size: 28,
          ),
          Icon(
            Icons.health_and_safety_outlined,
            color: white,
            size: 28,
          ),
          Icon(
            Icons.feed_outlined,
            color: white,
            size: 28,
          ),
          Icon(
            Icons.settings_outlined,
            color: white,
            size: 28,
          ),
        ],
        onTap: (index) {
          setState(() {
            indexpage = index;
          });
        },
      ),
    );
  }
}
