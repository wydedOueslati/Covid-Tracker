import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/config/styles.dart';
import 'package:covid19_news/data/data.dart';
import 'package:covid19_news/nonet.dart';
import 'package:covid19_news/urils/covidchart.dart';
import 'package:covid19_news/urils/statsgrid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsPage extends StatefulWidget {
  StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

Future<dynamic> getdata() async {
  const url =
      "https://api.covid19api.com/country/tunisia?from=2021-07-23T00:00:00Z&to=2021-07-24T00:00:00Z";
  try {
    final res = await http.get(Uri.parse(url)).timeout(
      Duration(seconds: 7),
      onTimeout: () {
        return http.Response("null", 408);
      },
    );
    if (res.statusCode == 408) {
      return "nonet";
    } else if (res.statusCode == 200) {
      print(res.body);
      final data = res.body;
      return data;
    } else {
      return "error";
    }
  } catch (e) {
    return e.toString();
  }
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(),
            _buildRegionTabBar(),
            _buildStatsTabBar(),
            FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else {
                    if (snapshot.data == "nonet") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoNetPage(),
                          ));
                      return Container();
                    } else {
                      var donnee = jsonDecode(snapshot.data.toString());
                      return Container(
                        child: StatsGrid(
                          tcase: donnee[1]["Confirmed"].toString(),
                          deaths: donnee[1]["Deaths"].toString(),
                          recovred: donnee[1]["Recovered"].toString(),
                        ),
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      'Statistics',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildRegionTabBar() {
  return Container(
    child: DefaultTabController(
      length: 2,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TabBar(
          indicator: BubbleTabIndicator(
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            indicatorHeight: 40.0,
            indicatorColor: Colors.white,
          ),
          labelStyle: Styles.tabTextStyle,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          tabs: <Widget>[
            Text('My Country'),
            Text('Global'),
          ],
          onTap: (index) {},
        ),
      ),
    ),
  );
}

Widget _buildStatsTabBar() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: DefaultTabController(
      length: 3,
      child: TabBar(
        indicatorColor: Colors.transparent,
        labelStyle: Styles.tabTextStyle,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        tabs: <Widget>[
          Text('Total'),
          Text('Today'),
          Text('Yesterday'),
        ],
        onTap: (index) {},
      ),
    ),
  );
}
