import 'package:covid19_news/dash/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../config/colors.dart';

class NoNetPage extends StatelessWidget {
  const NoNetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
           Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [   
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),        
                Image.asset('assets/images/nonet.png',
                 width: 160.0,
                 height: 160.0,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),           
                Text('Oops!',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text('There is no Internet connecton \n Please check your Internet connecton',
                 textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // OutlinedButton(
                //   onPressed: ()  {
                //     SchedulerBinding.instance!.addPostFrameCallback((_) {
                //      Navigator.pop(context);
                //         });
                   
                //     // Respond to button presszz
                //         },
                  // style: ButtonStyle(
                  // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //    RoundedRectangleBorder(
                  //    borderRadius: BorderRadius.circular(18.0),
                  //         )
                  //           )
                  //     ),      
                  // child: Text("Try again",
                  // style: TextStyle(
                  //   color: Colors.black,
                  //   fontSize: 15.0,
                  // ),),
                  //   ),
               ]
          ),
           ),
        
      )
    ;
  }
}
