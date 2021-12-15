import 'package:covid19_news/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Center(
        child: SpinKitChasingDots(
          color: colorPrimary,
          size: 50.0,
        ),
      ),
    );
  }
}