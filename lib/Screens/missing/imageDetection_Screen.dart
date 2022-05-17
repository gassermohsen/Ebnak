import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Size_config/size_config.dart';
import '../../constants/constants.dart';

class ImageDetectionScreen extends StatelessWidget {
  const ImageDetectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var DetectionImage=EbnakCubit.get(context).DetectionImage;

        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                if(EbnakCubit.get(context).DetectionImage!=null)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                        height: getProportionateScreenHeight(700),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image:  FileImage(DetectionImage!) ,
                            fit: BoxFit.cover,
                          ),
                        ),
                          child:Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0,top: 10,bottom: 10,right: 10),
                                child: Align(
                                  alignment: AlignmentDirectional.bottomStart,
                                  child: Container(
                                    width: getProportionateScreenWidth(150),
                                    height: getProportionateScreenHeight(50),

                                    child: OutlinedButton(onPressed: (){},
                                      clipBehavior: Clip.hardEdge,
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          width: 2.0,
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),

                                        shape:  RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10),

                                            ),
                                        ),


                                      ),

                                      child: Text('Cancel',style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15),
                                child: Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: Container(
                                    width: getProportionateScreenWidth(150),
                                    height: getProportionateScreenHeight(50),
                                    child: ElevatedButton(onPressed: (){},
                                      child: Text('Detect',style: TextStyle(color: Colors.white),),
                                      clipBehavior: Clip.hardEdge,

                                      style: ElevatedButton.styleFrom(
                                        shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10),

                                        ),

                                      ),
                                        primary: Colors.teal.shade100,


                                      ),

                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),

                          ),
                        IconButton(
                          color: Colors.white,
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            EbnakCubit.get(context).removeDetectionImage();
                          },
                        ),

                      ],
                    ),

                  ),


              ],
            )
        );
      },
    );
  }
}
