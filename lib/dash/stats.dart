import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/config/styles.dart';
import 'package:covid19_news/data/data.dart';
import 'package:covid19_news/nonet.dart';
import 'package:covid19_news/utils/covidchart.dart';
import 'package:covid19_news/utils/statsgrid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class StatsPage extends StatefulWidget {

 
  StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}
String? text;
int? locIndex=0;
int? dateIndex=0;
Future<dynamic>? myFuture; 
Future<dynamic> getdata(url) async {
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
  void initState() {
    // TODO: implement initState
    super.initState();
     text="My Country";
     locIndex=0;
     dateIndex=0;
    myFuture = getdata("https://corona.lmao.ninja/v2/countries/tunisia");
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
              ),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildRegionTabBar(context),
                  _buildStatsTabBar(),
                ],
              ),
            ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),           
               Center(
              child: Text(
                text.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
               ),
      ),
            FutureBuilder(
                future: myFuture,
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
                      if (dateIndex==0)
                     { return Container(
                        height: MediaQuery.of(context).size.height*0.5,
                        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                        color: white,
                        child: StatsGrid(
                          tcase: donnee["cases"].toString(),
                          deaths: donnee["deaths"].toString(),
                          recovered: donnee["recovered"].toString(),
                          critical: donnee["critical"].toString(),

                        ),
                      );}
                      else{
                        print("hii"+dateIndex.toString());
                        return Container(
                        height: MediaQuery.of(context).size.height*0.5,
                        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                        color: white,
                        child: StatsGrid(
                          tcase: donnee["todayCases"].toString(),
                          deaths: donnee["todayDeaths"].toString(),
                          recovered: donnee["todayRecovered"].toString(),
                          critical: donnee["critical"].toString(),

                        ),
                      );
                      }
                    }
                  }
             }),
          ],
        ),
      ),
    );
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

Widget _buildRegionTabBar(context) {
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
          onTap: (index) {
            print(index.toString());
            if (index==1)
            {
              setState(() {
                myFuture = getdata("https://corona.lmao.ninja/v2/all");
                locIndex=1;
                text="Global";
              });

            }else if (index==0) 
            {
              setState(() {
                myFuture = getdata("https://corona.lmao.ninja/v2/countries/tunisia");
                locIndex=0;
                 text="My Country";
              });
            }

          },
        ),
      ),
    ),
  );
}

Widget _buildStatsTabBar() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: DefaultTabController(
      length: 2,
      child: TabBar(
        indicatorColor: Colors.transparent,
        labelStyle: Styles.tabTextStyle,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        tabs: <Widget>[
          Text('Total'),
          Text('Today'),
        ],
        onTap: (index) {
          if (index==1 && locIndex==0)
            {
              setState(() {
                dateIndex=1;
                myFuture = getdata("https://corona.lmao.ninja/v2/countries/tunisia");
              });

            }else if (index==1 && locIndex==1)
            {
              setState(() {
                dateIndex=1;
                myFuture = getdata("https://corona.lmao.ninja/v2/all");
              });

            }
            else if (index==0 && locIndex==0) 
            {
              setState(() {
                dateIndex=0;
                myFuture = getdata("https://corona.lmao.ninja/v2/countries/tunisia");
              });
            }
            else if (index==0 && locIndex==1) 
            {
              setState(() {
                dateIndex=0;
                myFuture = getdata("https://corona.lmao.ninja/v2/all");
              });
            }

        },
      ),
    ),
  );
}

}

