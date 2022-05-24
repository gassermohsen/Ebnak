import 'dart:typed_data';

import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../Size_config/size_config.dart';
import '../../models/reportMissing_model.dart';
import '../../styles/icon_broken.dart';

class DetailsDetectionScreen extends StatefulWidget {
  const DetailsDetectionScreen({Key? key}) : super(key: key);

  @override
  State<DetailsDetectionScreen> createState() => _DetailsDetectionScreenState();
}
class _DetailsDetectionScreenState extends State<DetailsDetectionScreen> {
  int currentPage = 0;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Screenshot(
      controller:controller,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    itemBuilder: (BuildContext context, int index) => SingleChildScrollView(
                      child: buildDetailsPageView(EbnakCubit.get(context).getDetectionInfo[index],index),
                    ),
                  itemCount:EbnakCubit.get(context).getDetectionInfo.length,
                  onPageChanged:  (value) {
                  setState(() {
                  currentPage = value;
                  });
                  },
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30),),
                child: Container(
                  width: getProportionateScreenWidth(300),
                  height: getProportionateScreenHeight(50),
                  child: MaterialButton(

                    onPressed: ()async {
                      final image = await controller.capture();
                      if(image == null )return;
                      await saveImage(image);

                    },
                    color: Colors.teal.shade200,
                    elevation: 5,

                    child: Text('Take a ScreenShot'),
                    textColor: Colors.white,


                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }

  SingleChildScrollView buildDetailsPageView(reportMissingModel model,index) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor:kPrimaryColor,
                child: Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Colors.white,
                ),
              ),

            ),
            Text('Congrats!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kPrimaryColor),),
            Padding(
              padding:  EdgeInsets.only(left: 35.0,right: 35,top: 5),
              child: Text('The biometric data of your image match with this report.',style: TextStyle(fontSize: 15), textAlign: TextAlign.center,),
            ),
            Padding(
              padding:  EdgeInsets.all(25.0),
              child: Container(
                height: getProportionateScreenHeight(200),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image:  NetworkImage('${model.reportMissingImage}'),
                    fit: BoxFit.contain,

                  ),
                ),

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                SizedBox(width: getProportionateScreenWidth(5),),
                Text('${model.fullName}',style: TextStyle(fontSize: 16),),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Confidence :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                SizedBox(width: getProportionateScreenWidth(5),),
                Text('${EbnakCubit.get(context).findSimilarModel[index].confidence!*100} %',style: TextStyle(fontSize: 16),),

              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                EbnakCubit.get(context).getDetectionInfo.length,
                    (index) => buildDot(index: index),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(20),),
            Padding(
              padding:  EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 20),
                    child: Text('Age',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: 200),
                    child: Text('Report Date',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
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
                      Text('Missing Address',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18)),
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
                        Text('Phone Number ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18)),
                        Container(
                            height: getProportionateScreenHeight(70),

                            child: Text('${model.phoneNumber}',softWrap: false,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),maxLines: 5,)),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            Text('Additional Information',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
            Padding(
              padding:  EdgeInsets.all(10.0),
              child: Text('${model.Information}',maxLines: 5,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
            ),
            SizedBox(height: getProportionateScreenHeight(30),),
         






          ],
        ),
      );
  }



AnimatedContainer buildDot({int? index}) {
  return AnimatedContainer(
    duration: kAnimationDuration,
    margin: EdgeInsets.only(right: 5),
    height: 6,
    width: currentPage == index ? 20 : 6,
    decoration: BoxDecoration(
      color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
      borderRadius: BorderRadius.circular(3),
    ),
  );
}


Future <String> saveImage (Uint8List bytes) async{
    await [Permission.storage].request();
    final time =DateTime.now()
    .toIso8601String()
    .replaceAll(('.'), ('_'))
    .replaceAll(':', '_');
    final name = 'ScreenShot_$time';
    final result=await ImageGallerySaver.saveImage(bytes,name: name);
    return result['filePath'];
}


}


