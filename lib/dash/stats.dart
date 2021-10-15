import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/config/styles.dart';
import 'package:covid19_news/dash/symptoms.dart';
import 'package:covid19_news/data/data.dart';
import 'package:covid19_news/screens/nonet.dart';
import 'package:covid19_news/translations/locale_keys.g.dart';
import 'package:covid19_news/utils/covidchart.dart';
import 'package:easy_localization/easy_localization.dart';
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
      return "errorhere";
    }
  } catch (e) {
    return "nonet";
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
              
            FutureBuilder(
                future: myFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[ 
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),           
                        CircularProgressIndicator(),
                      ])),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.data == "nonet") {
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(builder: (context) => NoNetPage()),
                      //   );
                       return NoNetPage();
                    } else {
                      var donnee = jsonDecode(snapshot.data.toString());
                      if (dateIndex==0)
                     { return Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        color: white,
                        child: Column(
                          children: [
                            Center(
                            child: Text(
                               text.toString(),
                               textAlign: TextAlign.center,
                                style: const TextStyle(
                                fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                                      ),
                                        ),
                                ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            StatsGrid(
                              tcase: donnee["cases"].toString(),
                              deaths: donnee["deaths"].toString(),
                              recovered: donnee["recovered"].toString(),
                              critical: donnee["critical"].toString(),

                            ),
                             SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            _buildActiveCard(donnee["active"].toString(),donnee["population"].toString()),
                          ],
                        ),
                      );}
                      else{
                        print("hii"+dateIndex.toString());
                        return Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        color: white,
                        child: Column(
                          children: [           
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
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              StatsGrid(
                              tcase: donnee["todayCases"].toString(),
                              deaths: donnee["todayDeaths"].toString(),
                              recovered: donnee["todayRecovered"].toString(),
                              critical: donnee["critical"].toString(),

                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            _buildActiveCard(donnee["active"].toString(),donnee["population"].toString()),
                          ],
                        ),
                      );
                      }
                    }
                  }
             ),
          ],
        ),
      ),
    );
  }
 Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      LocaleKeys.statistics.tr(),
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
            Text(LocaleKeys.my_country.tr()),
            Text(LocaleKeys.global.tr()),
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
          Text(LocaleKeys.total.tr()),
          Text(LocaleKeys.today.tr()),
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
Widget _buildActiveCard(String active, String population) {
  return Container(
    padding: const EdgeInsets.all(25.0),
    decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                    color: Colors.grey,
                    blurRadius:6,
                    offset: Offset(4,4), // Shadow position
                   ),
                 ],
               ),
              width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Text('Active :',
           style: TextStyle(
             fontSize: 18.0,
             fontWeight: FontWeight.bold,
           ),),
           Text(active,),
        ],),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        new Divider(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
           Text('Population :',
           style: TextStyle(
             fontSize: 18.0,
             fontWeight: FontWeight.bold,
           ),),
           Text(population),
        ],),
      ],)
  );
}
}

