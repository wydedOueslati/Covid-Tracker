import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/dash/favorite.dart';

import 'package:flutter/material.dart';

class favoriteScreen extends StatefulWidget {
  favoriteScreen({Key? key}) : super(key: key);

  @override
  _favoriteScreenState createState() => _favoriteScreenState();
}

class _favoriteScreenState extends State<favoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: 500.0,
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: Center(
              child: _buildHeader(),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            child: Favorite(),
          ),
        ]),
      ),
    );
  }
}

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      'Favorite',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
