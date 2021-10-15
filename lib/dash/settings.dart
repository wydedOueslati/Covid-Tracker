import 'package:covid19_news/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/config/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';



class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selectedPos = 1;
  bool notification = true;
  
  String? _selectedLocation = 'English';

  double? width;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
  }

  Widget settingItem(String name, {required IconData icon, var pad = 10.0}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16),
              width: width! / 7.5,
              height: width! / 7.5,
              padding: EdgeInsets.all(width! / 30),
            
    
              child: Icon(icon),
            ),
            Text(name,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    

    return Scaffold(
      backgroundColor: settings_LayoutBackgroundWhite,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Container(
              width: 500.0,
              decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
              ),
              ),
              child: Center(child: _buildHeader()),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    
                    children: <Widget>[
                      
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(LocaleKeys.general.tr(),
                          style: TextStyle(color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          settingItem(LocaleKeys.language.tr(), icon:Icons.translate),
                          DropdownButton<String>(
                            icon: Icon(Icons.keyboard_arrow_right,
                                color: settings_TextColorSecondary),
                            underline: SizedBox(),
                            value: _selectedLocation,
                            items: <String>['English','Arabic']
                                .map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    ),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              setState(() {
                                _selectedLocation = newValue;
                              });
                              if(newValue=='Arabic'){
                                  await context.setLocale(Locale('ar'));
                                }
                              else if(newValue=='English'){
                                  await context.setLocale(Locale('en'));
                                }
                            },
                          ),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                      const Divider(
                       height: 15,
                       thickness: 1.2,
                       indent: 25,
                       endIndent: 30,
                       ),
                      Container(
                         child: Row(
                          children: <Widget>[
                            settingItem(LocaleKeys.notification.tr(),
                                icon: Icons.notifications_on_outlined),
                            Switch(
                              value: notification,
                              onChanged: (value) {
                                setState(() {
                                  notification = value;
                                  print(notification);
                                });
                                if(value==true){
                                   OneSignal.shared.disablePush(false);
                                    showInSnackBar('Notifications enabled!');
                                }
                                else if(value==false){
                                  OneSignal.shared.disablePush(true);
                                  showInSnackBar('Notifications disabled!');
                                }
                              },
                              
                            ),
                        SizedBox(
                            width: 16,
                        )
                          ],
                        ),
                      ),
                      SizedBox(
                           height: 16,
                        ),
                      //   SizedBox(
                      //   width: double.infinity,
                      //   child: Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //     child: Text('More',
                      //     style: TextStyle(color: Colors.black,
                      //     fontSize: 18.0,
                      //     fontWeight: FontWeight.bold,
                      //     ),
                      //     textAlign: TextAlign.start,
                          
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0,10),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(value) ),
      ),behavior: SnackBarBehavior.floating,
      ));
  }
}

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      LocaleKeys.settings.tr(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  
}

