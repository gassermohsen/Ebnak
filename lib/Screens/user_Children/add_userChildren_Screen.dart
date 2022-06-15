import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/Screens/user_Children/viewAllMembers_Screen.dart';
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

class addUserChildrenScreen extends StatefulWidget {
  const addUserChildrenScreen({Key? key}) : super(key: key);

  @override
  State<addUserChildrenScreen> createState() => _addUserChildrenScreenState();
}

class _addUserChildrenScreenState extends State<addUserChildrenScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Text('Complete your \nFamily Tree ',style: headingStyle,textAlign: TextAlign.center,)),
            Stack(
              children: [
                Image(image: NetworkImage(
                  'https://img.freepik.com/free-vector/isolated-tree-white-background_1308-24265.jpg?t=st=1655295844~exp=1655296444~hmac=ffcac25de711b1bccaa6652f6a4f36e03d04d586a36f97571638183989794304&w=996'
                ),
                width: double.infinity,
                  height: getProportionateScreenHeight(400),
                ),

              ],
            ),

            SizedBox(height: getProportionateScreenHeight(40),),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,top: 10,bottom: 10,right: 10),
                  child: Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Container(
                      width: getProportionateScreenWidth(160),
                      height: getProportionateScreenHeight(60),

                      child: OutlinedButton(onPressed: (){

                        navigateAndFinish(context, EbnakLayout());

                      },
                        clipBehavior: Clip.hardEdge,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 2.0,
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),

                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10),

                            ),
                          ),


                        ),

                        child: Text('Cancel',style: TextStyle(color: Colors.black87),),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15),
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      width: getProportionateScreenWidth(160),
                      height: getProportionateScreenHeight(60),
                      child: ElevatedButton(onPressed: () async {
                        PushReplacment(context, AddmemberScreen());

                      },
                        child: Text('Add Member',style: TextStyle(color: Colors.white),),
                        clipBehavior: Clip.hardEdge,

                        style: ElevatedButton.styleFrom(
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10),

                            ),

                          ),
                          primary: kPrimaryColor,


                        ),

                      ),
                    ),
                  ),
                ),


              ],
            ),


          ],
        ),
      ),

    );
  },
);
  }
}
