import 'package:flutter/material.dart';

class NoNetPage extends StatelessWidget {
  const NoNetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("No internet connection"),
      ),
    );
  }
}
