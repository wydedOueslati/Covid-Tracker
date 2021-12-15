import 'package:covid19_news/screens/helpful_info.dart';
import 'package:covid19_news/screens/homescreen.dart';
import 'package:covid19_news/screens/splashScreen.dart';
import 'package:covid19_news/screens/wrapper.dart';
import 'package:covid19_news/services/auth.dart';
import 'package:covid19_news/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';


import 'models/myuser.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
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
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Covid 19 news app',
        debugShowCheckedModeBanner: false,
        home:Wrapper(),
      ),
    );
  }
}

