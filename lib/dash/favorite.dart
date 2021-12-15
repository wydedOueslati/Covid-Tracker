// ignore_for_file: unused_local_variable
import 'package:path/path.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Map> data = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_favorites.db');
    Database database = await openDatabase(path, version: 1);
    List<Map> list = await database.rawQuery('SELECT * FROM favorites');
    print("my data is " + list.toString());
    setState(() {
      data = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // List _articleList = [];
    return data == []
        ? Text('No saved articles yet')
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              int currentIndex = index;
              return GestureDetector(
                onTap: () async {
                  if (Platform.isAndroid) {
                    FlutterWebBrowser.openWebPage(
                      url: data[index]['url'],
                      customTabsOptions: CustomTabsOptions(
                        colorScheme: CustomTabsColorScheme.dark,
                        toolbarColor: Colors.deepPurple,
                        secondaryToolbarColor: Colors.green,
                        navigationBarColor: Colors.amber,
                        addDefaultShareMenuItem: true,
                        instantAppsEnabled: true,
                        showTitle: true,
                        urlBarHidingEnabled: true,
                      ),
                    );
                  } else if (Platform.isIOS) {
                    FlutterWebBrowser.openWebPage(
                      url: data[index]['url'],
                      safariVCOptions: SafariViewControllerOptions(
                        barCollapsingEnabled: true,
                        preferredBarTintColor: Colors.green,
                        preferredControlTintColor: Colors.amber,
                        dismissButtonStyle:
                            SafariViewControllerDismissButtonStyle.close,
                        modalPresentationCapturesStatusBarAppearance: true,
                      ),
                    );
                  } else {
                    await FlutterWebBrowser.openWebPage(
                        url: data[index]['url']);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            spreadRadius: 1)
                      ]),
                  margin: EdgeInsets.only(
                      bottom: height * 0.01,
                      top: height * 0.01,
                      left: width * 0.02,
                      right: width * 0.02),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                data[index]['image'] != null
                                    ? data[index]['image']!
                                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width * 0.55,
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Text(
                                data[index]['title'],
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "- " + data[index]['source'] + " -",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
