import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/screens/helpful_info.dart';
import 'package:covid19_news/translations/locale_keys.g.dart';
import 'package:covid19_news/utils/symptomsList.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';


class SymptomsPage extends StatefulWidget {
  SymptomsPage({Key? key}) : super(key: key);

  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
final symplist = [LocaleKeys.fever.tr(), LocaleKeys.dry_cough.tr(),LocaleKeys.fatigue.tr() ,LocaleKeys.sputum_production.tr(),LocaleKeys.shortness_of_breath.tr(),LocaleKeys.muscle_pain.tr(),LocaleKeys.sore_throat.tr(),LocaleKeys.headache.tr(),LocaleKeys.chills.tr(),];
  final perclist = [ "87.9%","67.7%","38.1%","33.4%","18.6%","14.8%","13.9%","13.6%","11.4%",];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];

  @override
  Widget build(BuildContext context) {
     return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
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
            Container(
                decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                    color: Colors.grey,
                    blurRadius:5,
                    offset: Offset(0,3), // Shadow position
                   ),
                 ],
               ),
               margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 25.0),
              height: MediaQuery.of(context).size.height * 0.60,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                  itemCount:symplist.length,
                  itemBuilder: (context, index) {
                     return SizedBox(
                       height: 30,
                       child: ListTile(
                         leading: Text(symplist[index],style: TextStyle(fontWeight: FontWeight.bold)),
                         trailing: Text(perclist[index],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                          ),
                     );
                   },
                  separatorBuilder: (context, index) {
                      return Divider();
                     },),
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Center(
                child: Text.rich(
              TextSpan(
                text: LocaleKeys.source.tr()+' ',
                style: TextStyle(fontSize: 13,color:Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                      text: LocaleKeys.centers_for_disease.tr(),
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.red,
                      ),
                      recognizer: new TapGestureRecognizer()..onTap = () => launch("https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html"),

                      ),
                ],
              ),
            )
                 ),
                 ),
              Container(
                decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(12),
                 boxShadow: [
                   BoxShadow(
                    color: Colors.grey,
                    blurRadius:5,
                    offset: Offset(0,3), // Shadow position
                   ),
                 ],
               ),
              margin: const EdgeInsets.only(left: 17.0, right: 17.0),
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.12,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: Colors.grey),
                    child: Center(
                      child: Text('I think I\'m infected, now \nwhat? ',
                      style: TextStyle(
                        color: white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30.0),
                decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                    color: Colors.grey,
                    blurRadius:5,
                    offset: Offset(0,3), // Shadow position
                   ),
                 ],
               ),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.12,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      color: Colors.red),
                    child:GestureDetector(
                    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Helpful_info())); },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:Row(
                              children:
                              [
                               Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: IconButton( icon: Icon(Icons.article_outlined),onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Helpful_info()));
                                }, color: white,),
                              ),
                            Text('Read this information',
                            style: TextStyle(color: white, fontSize: 15),),])),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton( icon: Icon(Icons.chevron_right_outlined),onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Helpful_info()));
                              }, color: Colors.white54,)),
                          ],
                        ),
                        
                      ),
                    )

              ),
              ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      LocaleKeys.symptoms.tr(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

