import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/config/styles.dart';
import 'package:covid19_news/data/data.dart';
import 'package:covid19_news/utils/dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


String _country = 'USA';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        _buildHeader(screenHeight,context),
        _buildPreventionTips(screenHeight),
        _buildYourOwnTest(screenHeight),
      ],
    );
  }
}

SliverToBoxAdapter _buildHeader(double screenHeight, context) {

  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Text(
                'douda',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Are you feeling sick?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'If you feel sick with any COVID-19 symptoms, please ask immediately for help',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  FlatButton.icon(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    onPressed: (){
                       print("click me");
                      const tel ='tel:190';
                       //launch(tel);
                       context.locale = Locale('ar');
                       },
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    label: Text(
                      'call',
                      style: Styles.buttonTextStyle,
                    ).tr(),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Prevention Tips',
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: prevention
                .map((e) => Column(
                      children: <Widget>[
                        Image.asset(
                          e.keys.first,
                          height: screenHeight * 0.12,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          e.values.first,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    ),
  );
}

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){
          print("Container clicked");
          const url ='https://evax.tn/';
          launch(url);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.all(10.0),
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEEEEEE), Colors.grey],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/images/own_test.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Let’s Go Get Our Vaccine!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'protect yourself \nand your loved ones. ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    maxLines: 2,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }