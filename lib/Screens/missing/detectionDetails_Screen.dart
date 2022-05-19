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
        body: SingleChildScrollView(
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
                padding: const EdgeInsets.only(left: 35.0,right: 35,top: 5),
                child: Text('The biometric data of your image match with this report.',style: TextStyle(fontSize: 15), textAlign: TextAlign.center,),
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: getProportionateScreenHeight(200),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image:  NetworkImage('https://firebasestorage.googleapis.com/v0/b/ebnak-305a8.appspot.com/o/users%2Fimage_picker2624027628376151737.jpg?alt=media&token=2e773167-321d-447f-a085-f0747be8eb2b') ,
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
                  Text('Se7s bonos',style: TextStyle(fontSize: 16),),

                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20),),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Age',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Text('Report Date',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('15',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(220),
                    ),

                    Flexible(child: Text('2022-05-18 01:54:45.14075',maxLines: 2,textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),)),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 8),
                child: Row(
                  children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('Missing Address',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18)),
                        Container(
                            width: getProportionateScreenWidth(220),
                            height: getProportionateScreenHeight(70),
                            child: Text('Shiekh zayed city amal street ',softWrap: true,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),maxLines: 5,)),
                      ],
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text('Phone Number ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18)),
                          Container(
                              height: getProportionateScreenHeight(70),

                              child: Text('01150168031',softWrap: false,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),maxLines: 5,)),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              Text('Additional Information',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Last day this kid found was in the street of fada please contact us to be sure that adbadahbdahjahd',maxLines: 5,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
              ),
        SizedBox(height: getProportionateScreenHeight(30),),
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


