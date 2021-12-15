import 'package:covid19_news/models/myuser.dart';
import 'package:covid19_news/screens/authenticate/authenticate.dart';
import 'package:covid19_news/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print(user);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Homescreen();
    }
    
  }
}