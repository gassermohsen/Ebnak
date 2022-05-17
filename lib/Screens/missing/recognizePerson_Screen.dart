import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebnak1/Screens/missing/imageDetection_Screen.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../layout/ebnak/cubit/ebnak_cubit.dart';
import '../../shared/re_useable_components.dart';

class RecognizePersonScreen extends StatelessWidget {
  const RecognizePersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
        if(EbnakCubit.get(context).DetectionImage!=null)
          navigateTo(context, ImageDetectionScreen());
      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: Text('Detect'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Image(
                        height: getProportionateScreenHeight(300),
                        image: AssetImage(
                            'assets/images/pablo-face-recognition.png'
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            radius: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Please Upload an Image for the recognition',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.cyanAccent,
                            radius: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('Image must be the face with high quality ',
                              textAlign: TextAlign.start,
                              textHeightBehavior: TextHeightBehavior(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,

                                  fontSize: 15
                              ),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.pink.shade300,
                            radius: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('This may take a while to be completed',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(70),
                    ),


                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30),),
                      child: Container(
                        width: getProportionateScreenWidth(300),
                        height: getProportionateScreenHeight(50),
                        child: MaterialButton(

                          onPressed: () {
                            EbnakCubit.get(context).getDetectionImage();
                          },
                          color: kPrimaryColor,
                          elevation: 5,

                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Image(

                                    height: getProportionateScreenHeight(40),
                                    image: AssetImage(
                                        'assets/images/icons8-face-recognition-64.png'
                                    )),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(25),
                              ),
                              Text(
                                'Pick an Image ', style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          textColor: Colors.white,


                        ),
                      ),
                    ),



                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
