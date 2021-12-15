import 'dart:io';

import 'package:covid19_news/blocs/newsbloc/news_bloc.dart';
import 'package:covid19_news/blocs/newsbloc/news_states.dart';
import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/dash/favoritescreen.dart';
import 'package:covid19_news/models/article_model.dart';
import 'package:covid19_news/screens/nonet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsuiScreen extends StatefulWidget {
  @override
  _NewsuiScreenState createState() => _NewsuiScreenState();
}

class _NewsuiScreenState extends State<NewsuiScreen> {
  @override
  void initState() {
    super.initState();
    openDB();
  }

  openDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_favorites.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          '''CREATE TABLE favorites (ID INTEGER PRIMARY KEY,title TEXT, image TEXT,source TEXT)''');
    });
  }

  StoreData(title, image, source, url) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_favorites.db');
    Database database = await openDatabase(path, version: 1);

    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO favorites(title, image,source,url) VALUES("$title","$image","$source","$url")');
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          color: Colors.white,
          child: BlocBuilder<NewsBloc, NewsStates>(
            builder: (BuildContext context, NewsStates state) {
              if (state is NewsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsLoadedState) {
                List<ArticleModel> _articleList = [];
                _articleList = state.articleList;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(_articleList));
                            },
                            icon: const Icon(Icons.search)),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => favoriteScreen()),
                    //     );
                    //     // .then((value) => setState(() {}));
                    //   },
                    //   child: Text('open'),
                    // ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _articleList.length,
                      itemBuilder: (context, index) {
                        int currentIndex = index;
                        return GestureDetector(
                          onTap: () async {
                            if (Platform.isAndroid) {
                              FlutterWebBrowser.openWebPage(
                                url: _articleList[index].url!,
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
                                url: _articleList[index].url!,
                                safariVCOptions: SafariViewControllerOptions(
                                  barCollapsingEnabled: true,
                                  preferredBarTintColor: Colors.green,
                                  preferredControlTintColor: Colors.amber,
                                  dismissButtonStyle:
                                      SafariViewControllerDismissButtonStyle
                                          .close,
                                  modalPresentationCapturesStatusBarAppearance:
                                      true,
                                ),
                              );
                            } else {
                              await FlutterWebBrowser.openWebPage(
                                  url: _articleList[index].url!);
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
                                            _articleList[index].urlToImage !=
                                                    null
                                                ? _articleList[index]
                                                    .urlToImage!
                                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.5,
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.01),
                                        child: Text(
                                          _articleList[index].title!,
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
                                          "- " +
                                              _articleList[index]
                                                  .source!
                                                  .name! +
                                              " -",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: state.isFav[index]
                                      ? const Icon(Icons.bookmark,
                                          color: colorPrimary, size: 30)
                                      : const Icon(
                                          Icons.bookmark_border_outlined,
                                          color: colorPrimary,
                                          size: 30),
                                  tooltip: 'Save this article',
                                  onPressed: () {
                                    // _toggleFavorite();
                                    setState(() {
                                      state.isFav[index] = !state.isFav[index];
                                    });
                                    // insertArticle(
                                    //     index,
                                    //     _articleList[index].title.toString(),
                                    //     _articleList[index]
                                    //         .urlToImage
                                    //         .toString());
                                    StoreData(
                                      _articleList[index].title,
                                      _articleList[index].urlToImage,
                                      _articleList[index].source?.name,
                                      _articleList[index].url,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else if (state is NewsErrorState) {
                String error = state.errorMessage;

                return Center(child: NoNetPage());
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                ));
              }
            },
          ),
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<ArticleModel> searchItems;
  CustomSearchDelegate(this.searchItems) {
    searchItems = this.searchItems;
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
        //
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var article in searchItems) {
      if (article.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(article.title!);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var article in searchItems) {
      if (article.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(article.title!);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('Article found',
            //       style: TextStyle(color: Colors.lightBlue)),
            // ),
            ListTile(
              title: Text(result),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
