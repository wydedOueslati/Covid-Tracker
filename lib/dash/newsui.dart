import 'dart:io';

import 'package:covid19_news/blocs/newsbloc/news_bloc.dart';
import 'package:covid19_news/blocs/newsbloc/news_states.dart';
import 'package:covid19_news/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class NewsuiScreen extends StatefulWidget {
  @override
  _NewsuiScreenState createState() => _NewsuiScreenState();
}

class _NewsuiScreenState extends State<NewsuiScreen> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
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
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true, 
                      itemCount: _articleList.length,
                      itemBuilder: (context, index) {
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
                            height: height * 0.15,
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
                                                ? _articleList[index].urlToImage!
                                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                            vertical:2.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.55,
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
                                          "- "+_articleList[index].source!.name!+" -",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state is NewsErrorState) {
                  String error = state.errorMessage;

                  return Center(child: Text(error));
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ));
                }
              },
            ),
    );
  }
}