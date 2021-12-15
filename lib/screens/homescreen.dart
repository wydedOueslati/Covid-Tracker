import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/dash/home.dart';
import 'package:covid19_news/dash/stats.dart';
import 'package:covid19_news/dash/symptoms.dart';
import 'package:covid19_news/dash/test.dart';
import 'package:covid19_news/dash/news.dart';
import 'package:covid19_news/utils/NavigationDrawerWidget.dart';
import 'package:covid19_news/utils/bottommenu.dart';
import 'package:flutter/material.dart';

import '../dash/settings.dart';
import './helpful_info.dart';

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
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorPrimary,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.privacy_tip_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Helpful_info()));
            },
          )
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
