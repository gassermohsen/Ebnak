import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../Size_config/size_config.dart';
import '../../models/addMember_model.dart';

class reportMyChildrenScreen extends StatefulWidget {


  @override
  State<reportMyChildrenScreen> createState() => _reportMyChildrenScreenState();
}

class _reportMyChildrenScreenState extends State<reportMyChildrenScreen> {
  var  currentPos;

  var currentLat;

  var currentLong;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position pos) async {
      setState(() {
        currentPos = pos;
        currentLat = pos.latitude;
        currentLong = pos.longitude;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
  listener: (context, state) {
    if(state is EbnakGetUserMembersLoadingState){
      Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,

        ),
      );
    }

    if(state is EbnakCreateReportSuccessState){
      showToast(text: 'Your Child Reported Successfully', state: ToastStates.SUCCESS);
      Navigator.pop(context);
    }

  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Children'),
      ),
      body:
      ListView.separated(
          itemBuilder:  (context,index)=> buildMyChild(EbnakCubit.get(context).userMembersForReport[index],context,index),
          separatorBuilder: (context,index)=> Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Divider(
              thickness:2,
              height: 40,
              color: Colors.grey[300],
            ),
          ), itemCount: EbnakCubit.get(context).userMembersForReport.length),
    );
  },
);
  }

  Column buildMyChild(addMemberModel model,context,index) {
    return Column(
      children: [
        Center(
          child: Container(
            height: getProportionateScreenHeight(50),
            width: getProportionateScreenWidth(150),

            child: Row(
              children: [
                Icon(
                  IconBroken.Danger,
                  color: Colors.red,
                  size: 32,
                ),
                SizedBox(width: getProportionateScreenWidth(3),),
                Text('Missing',style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
        Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Container(
            width: getProportionateScreenWidth(300),
            height: getProportionateScreenHeight(300),
            decoration: BoxDecoration(
              color: Colors.redAccent,

              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [

                Center(
                child: Image(image: NetworkImage(
                  '${model.memberImage}'
                ),
                fit: BoxFit.contain,),
              ),
                Positioned(
                  bottom: 10,
                    left: 60,
                    child:
                OutlinedButton(
                  onPressed: () {

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(

                        title:  Text('Report'),
                        content:  Text('Are you sure you want to Report ${model.fullName} for missing ! '),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel',style: TextStyle(color: Colors.grey),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Cancel');
                              var nowTime= DateTime.now();
                              EbnakCubit.get(context).createReportmyChildren(

                                  Info: '${model.Information}',
                                  MissingAddress: '',
                                  dateTime: nowTime.toString(),
                                  currentLocation: GeoPoint(currentLat, currentLong),
                                  Age: '${model.Age}',
                                  fullName: '${model.fullName}',
                                  reportMissingImage: '${model.memberImage}',
                                  reportID: '');
                            },
                            child: const Text('Yes',style: TextStyle(color:Colors.red)),
                          ),
                        ],
                      ),
                    );

                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.red,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      width: 1.0,
                      color: Colors.red,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text('Report ${model.fullName} Missing !'),

                ),)

          ]
            ),
          ),
        ),
          )
      ],
    );
  }
}
