import 'package:covid19_news/homescreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MyApp()));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Future<void> initOnesignal() async {
    OneSignal.shared.setAppId("5e135c0a-5eb0-4434-bc83-fc7c3cbce669");
  }

  @override
  void initState() {
    super.initState();
    initOnesignal();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19 news app',
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
