import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/translations/locale_keys.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';


class Helpful_info extends StatelessWidget {
  const Helpful_info({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Helpful information',
        style: TextStyle(color: Colors.grey),),
        backgroundColor: Colors.blueGrey[50],
        leading: IconButton( icon: Icon(Icons.chevron_left_outlined),color:Colors.grey[700] ,onPressed: () {
          Navigator.pop(context);
          },),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                margin: const EdgeInsets.only(left: 17.0, right: 17.0, top: 25.0),
                //height: MediaQuery.of(context).size.height * 1.34,
                child: Column(
                children: [
                  Container(
                    padding:EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0 ) ,
                    child: Center(
                      child: Image(image: AssetImage('assets/images/covidvirus.png'),),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.09 ,
                    decoration: new BoxDecoration(
                      color: Colors.grey[800]),
                    child: Center(
                      child: Text('How do you get infected?',
                      style: TextStyle(
                        color: white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
                  Container(
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '1.',),
                            title: new Text('The main route of transmission is respiratory droplets and close contact with infected people.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '2.',),
                            title: new Text('When you sneeze or cough, you produce droplets of fluid from your nose and mouth.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '3.',),
                            title: new Text('These droplets can carry infection which can be spread to others by entering their eyes, nose or mouth. this is the way the flu and many other viruses are spread.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '4.',),
                            title: new Text('Usually, you need to be close to the person (within 6 feet) for the virus to spread this way.'),
                          ),
                       ),
                        Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '5.',),
                            title: new Text('There is also the possibility of aerosol transmission when exposed to high concentration aerosol for a longer period of time and in a relatively enclosed environment.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '6.',),
                            title: new Text('The WHO has stated that the risk of spread from someone without symptoms is "very low" and the chances of transmission are "low".'),
                          ),
                       ),
                     ],
                   ),
                  )
                ],
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
                margin: const EdgeInsets.only(left: 17.0, right: 17.0, top: 25.0),
                //height: MediaQuery.of(context).size.height * 0.50,
                child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.09 ,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      color: Colors.grey[800]),
                    child: Center(
                      child: Text('How can I protect myself?',
                      style: TextStyle(
                        color: white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                         Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '1.',),
                            title: new Text('Do not travel to the affected areas.'),
                          ),
                         ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '2.',),
                            title: new Text('When sneezing or coughing, cover your mouth with a tissue or elbow. Do not ever sneeze or cough in your palms.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '3.',),
                            title: new Text('Wash your hands frequently and thoroughly with soap and water.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '4.',),
                            title: new Text('Avoid obviously ill people and places with a high concentration of people.'),
                          ),
                       ),
                      ],
                    ),
                  )
                ])),
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
                margin: const EdgeInsets.only(left: 17.0, right: 17.0, top: 25.0),
                //height: MediaQuery.of(context).size.height * 0.66,
                child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.12,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      color: Colors.red[700]),
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
                  Container(
                    child: Column(
                      children: [
                         Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '1.',),
                            title: new Text('Inform Institution / Health Organization in your country via the emergency number, which will tell you what to do next.'),
                          ),
                         ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '2.',),
                            title: new Text('Self isolation at home has been recommended for people diagnosed with COVID-19 and those who suspect they have been infected.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '3.',),
                            title: new Text('Public Health agencies have issued self-isolation instructions which include notification of healthcare providers by phone and restricting all outdoor activities expect for getting medical care.'),
                          ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: new ListTile(
                            leading: new MyOrder( number: '4.',),
                            title: new Text('Do not go to work, school, or public areas. Avoid using public transportation, ride-sharing or taxis.'),
                          ),
                       ),
                      ],
                    ),
                  ),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: LocaleKeys.source.tr()+' ',
                          style: TextStyle(fontSize: 13,color: Colors.grey),
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
           ]  

        )
      ),
    ));

  }
  
}

class MyOrder extends StatelessWidget{
  String? number;

  MyOrder({required this.number});

  @override
  Widget build(BuildContext context ) {
    return Container(
      width: MediaQuery.of(context).size.width*0.1 ,
      height: MediaQuery.of(context).size.height,
      child: Align(alignment: Alignment.center,child: Text(number!,
      style: TextStyle(color: Colors.grey,
      fontSize: 18.0,
      ),
      )),
    );
  }}