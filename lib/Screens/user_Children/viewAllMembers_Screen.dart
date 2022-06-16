import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/layout/ebnak/ebnak_layout.dart';
import 'package:ebnak1/models/addMember_model.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/icon_broken.dart';
import 'add_Member_Screen.dart';

class viewAllmembers extends StatefulWidget {
  const viewAllmembers({Key? key}) : super(key: key);

  @override
  State<viewAllmembers> createState() => _viewAllmembers();
}

class _viewAllmembers extends State<viewAllmembers> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: Text('Continue'),

          ),
          body: Column(
            children: [
              Center(child: Text('Complete your \nFamily Tree ',style: headingStyle,textAlign: TextAlign.center,)),
              Stack(
                children: [
                  CachedNetworkImage(imageUrl:                       'https://img.freepik.com/free-vector/isolated-tree-white-background_1308-24265.jpg?t=st=1655295844~exp=1655296444~hmac=ffcac25de711b1bccaa6652f6a4f36e03d04d586a36f97571638183989794304&w=996'
                    ,
                    width: double.infinity,
                    height: getProportionateScreenHeight(400),
                  ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.data.docs.length >= 1){
                          EbnakCubit
                              .get(context)
                              .userMembers = [];


                          for (int i = 0; i <
                              snapshot.data!.docs.length; i++) {
                            EbnakCubit
                                .get(context)
                                .userMembers
                                ?.add(addMemberModel.fromSnapShot(
                                snapshot.data!.docs![i]));

                          }
                          return Positioned(
                          left: 25,
                          top: 160,
                          child: Column(
                            children: [
                              Text(EbnakCubit.get(context).userMembers![0].fullName??'',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 12),),

                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[200],
                                backgroundImage:NetworkImage(
                                    EbnakCubit.get(context).userMembers![0].memberImage
                                ),
                              ),
                              Text(EbnakCubit.get(context).userMembers![0].fullName??'',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 12),),
                            ],
                          ),
                            );

                        }
                        else{
                          return Text('');
                        }


                      },
                    ),
                  // if(EbnakCubit.get(context).userMembers.length >=2)
                  FutureBuilder(
                    future: FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.data.docs.length >= 2){
                        EbnakCubit
                            .get(context)
                            .userMembers = [];


                        for (int i = 0; i <
                            snapshot.data!.docs.length; i++) {
                          EbnakCubit
                              .get(context)
                              .userMembers
                              ?.add(addMemberModel.fromSnapShot(
                              snapshot.data!.docs![i]));

                        }
                        return Positioned(
                          left: 80,
                          top: 120,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[400],
                                backgroundImage:NetworkImage(
                                    EbnakCubit.get(context).userMembers![1].memberImage
                                ),
                              ),
                              Text(EbnakCubit.get(context).userMembers![1].fullName??'',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 12),)

                            ],
                          ),
                        );

                      }
                      else{
                        return Text('');
                      }


                    },
                  ),

                  // if(EbnakCubit.get(context).userMembers.length >=3)
                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.data.docs.length >= 3){
                          EbnakCubit
                              .get(context)
                              .userMembers = [];


                          for (int i = 0; i <
                              snapshot.data!.docs.length; i++) {
                            EbnakCubit
                                .get(context)
                                .userMembers
                                ?.add(addMemberModel.fromSnapShot(
                                snapshot.data!.docs![i]));

                          }
                          return Positioned(
                            left: 150,
                            top: 75,
                            child: Column(
                              children: [
                                Text(EbnakCubit.get(context).userMembers![2].fullName??'',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 12),),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[400],
                                  backgroundImage:NetworkImage(
                                      EbnakCubit.get(context).userMembers![2].memberImage
                                  ),
                                ),

                              ],
                            ),
                          );

                        }
                        else{
                          return Text('');
                        }


                      },
                    ),

                  // if(EbnakCubit.get(context).userMembers.length <=4)
                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if( snapshot.data.docs.length >= 4){
                          EbnakCubit
                              .get(context)
                              .userMembers = [];


                          for (int i = 0; i <
                              snapshot.data!.docs.length; i++) {
                            EbnakCubit
                                .get(context)
                                .userMembers
                                ?.add(addMemberModel.fromSnapShot(
                                snapshot.data!.docs![i]));

                          }
                          return Positioned(
                            left: 210,
                            top: 120,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[400],
                                  backgroundImage:NetworkImage(
                                      EbnakCubit.get(context).userMembers![3].memberImage
                                  ),
                                ),
                                Text(EbnakCubit.get(context).userMembers![3].fullName??'',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 12),)

                              ],
                            ),
                          );

                        }
                        else{
                          return Text('');
                        }


                      },
                    ),

                  // if(EbnakCubit.get(context).userMembers.length <=5)
                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.data.docs.length >= 5){
                          EbnakCubit
                              .get(context)
                              .userMembers = [];


                          for (int i = 0; i <
                              snapshot.data!.docs.length; i++) {
                            EbnakCubit
                                .get(context)
                                .userMembers
                                ?.add(addMemberModel.fromSnapShot(
                                snapshot.data!.docs![i]));

                          }
                          return Positioned(
                            left: 265,
                            top: 75,
                            child: Column(
                              children: [
                                Text(EbnakCubit.get(context).userMembers![4].fullName??'',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 12),),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[400],
                                  backgroundImage:NetworkImage(
                                      EbnakCubit.get(context).userMembers![4].memberImage
                                  ),
                                ),

                              ],
                            ),
                          );

                        }
                        else{
                          return Text('');
                        }


                      },
                    ),

                  // if(EbnakCubit.get(context).userMembers.length <=6)
                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.data.docs.length >= 6){
                          EbnakCubit
                              .get(context)
                              .userMembers = [];


                          for (int i = 0; i <
                              snapshot.data!.docs.length; i++) {
                            EbnakCubit
                                .get(context)
                                .userMembers
                                ?.add(addMemberModel.fromSnapShot(
                                snapshot.data!.docs![i]));

                          }
                          return Positioned(
                            left: 310,
                            top: 140,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[400],
                                  backgroundImage:NetworkImage(
                                      EbnakCubit.get(context).userMembers![5].memberImage
                                  ),
                                ),
                                Text(EbnakCubit.get(context).userMembers![5].fullName??'',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 12),),


                              ],
                            ),
                          );

                        }
                        else{
                          return Text('');
                        }


                      },
                    ),



                ],
              ),

            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: FloatingActionButton.extended(
              label:Text('Finish ',style: TextStyle(color: Colors.white),),
              icon:  Icon(Icons.done,color: Colors.white,),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                PushReplacment(context, EbnakLayout());
              },
              backgroundColor: kPrimaryColor,

              tooltip: 'Add Member',

            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
