import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/utils/symptomsList.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SymptomsPage extends StatefulWidget {
  SymptomsPage({Key? key}) : super(key: key);

  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
final symplist = ["Fever", "Dry cough", "Fatigue","sputum production","Shortness of breath","Muscle pain or joint pain","Sore throat","Headache","Chills","Nausea or vomiting"];
  final perclist = [ "87.9%","67.7%","38.1%","33.4%","18.6%","14.8%","13.9%","13.6%","11.4%","5.0%"];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];

  @override
  Widget build(BuildContext context) {
     return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
                decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                    color: Colors.grey,
                    blurRadius:6,
                    offset: Offset(4,4), // Shadow position
                   ),
                 ],
               ),
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width * 0.90,
              child: ListView.separated(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Container(
                child: Center(
                child: Text.rich(
  TextSpan(
    text: 'Source ',
    style: TextStyle(fontSize: 13),
    children: <TextSpan>[
      TextSpan(
          text: 'Centers for Disease Control and Prevention',
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
      'Symptoms',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

