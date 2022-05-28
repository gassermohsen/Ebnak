import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/reportMissing_model.dart';

class MarkerDetailsScreen extends StatelessWidget {
  final reportMissingModel model;

  const MarkerDetailsScreen(this.model,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(350),
                      decoration: BoxDecoration(
                        color:  Colors.red.shade300,
                      ),
                        child: CachedNetworkImage(imageUrl: model.reportMissingImage,fit: BoxFit.contain,)),
                  ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:  Colors.red.shade200),),
                SizedBox(width: getProportionateScreenWidth(5),),
                Text('${model.fullName}',style: TextStyle(fontSize: 16),),


              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Reporter Name :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:  Colors.red.shade200),),
                SizedBox(width: getProportionateScreenWidth(5),),
                Text('${model.name}',style: TextStyle(fontSize: 16),),


              ],
            ),




            SizedBox(height: getProportionateScreenHeight(20),),
            Padding(
              padding:  EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 20),
                    child: Text('Age',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color:  Colors.red.shade200),),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: 200),
                    child: Text('Report Date',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color:  Colors.red.shade200),),
                  ),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 20),
                    child: Text('${model.Age}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(220),
                  ),

                  Flexible(child: Text('${model.dateTime}',maxLines: 2,textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),)),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20,top: 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Missing Address',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color:  Colors.red.shade200)),
                      Container(
                          width: getProportionateScreenWidth(220),
                          height: getProportionateScreenHeight(70),
                          child: Text('${model.MissingAddress}',softWrap: true,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),maxLines: 5,)),
                    ],
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('Phone Number ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color:  Colors.red.shade200)),
                        Container(
                            height: getProportionateScreenHeight(70),

                            child: Text('${model.phoneNumber}',softWrap: false,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),maxLines: 5,)),
                      ],
                    ),
                  ),

                ],
              ),
            ),



            Text('Additional Information',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.red.shade200),),
            Padding(
              padding:  EdgeInsets.all(10.0),
              child: Text('${model.Information}',maxLines: 5,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
            ),
            SizedBox(height: getProportionateScreenHeight(30),),












          ],
        ),
      ),
    );
  }
}
