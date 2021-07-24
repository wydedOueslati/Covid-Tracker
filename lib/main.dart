import 'package:covid19_news/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19 news app',
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
