import 'package:ebnak1/Screens/missing/reportMissing_Screen.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Size_config/size_config.dart';
import '../../constants/constants.dart';
import '../../layout/ebnak/cubit/ebnak_cubit.dart';

class NoMatchingScreen extends StatelessWidget {
  const NoMatchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor:Colors.red,
              child: Icon(
                Icons.cancel_outlined,
                size: 80,
                color: Colors.white,
              ),
            ),

          ),
          Text('Sorry!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red),),
          Padding(
            padding:  EdgeInsets.only(left: 35.0,right: 35,top: 5),
            child: Text('The biometric data of your image has no match with any report.',style: TextStyle(fontSize: 15), textAlign: TextAlign.center,),
          ),
          SizedBox(
            height: getProportionateScreenHeight(50),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30),),
            child: Container(
              width: getProportionateScreenWidth(300),
              height: getProportionateScreenHeight(50),
              child: MaterialButton(

                onPressed: () {
                  PushReplacment(context, ReportMissingScreen());
                },
                color: Colors.red,
                elevation: 5,

                child: Text(
                  'Add Report if needed', style: TextStyle(fontSize: 18),),
                textColor: Colors.white,


              ),
            ),
          ),


        ],
      ),
    );
  }
}
