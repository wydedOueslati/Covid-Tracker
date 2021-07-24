import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/dash/home.dart';
import 'package:covid19_news/dash/stats.dart';
import 'package:covid19_news/dash/test.dart';
import 'package:covid19_news/urils/bottommenu.dart';
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
    TestPage(),
    TestPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorPrimary,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
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
            Icons.event_available_outlined,
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
