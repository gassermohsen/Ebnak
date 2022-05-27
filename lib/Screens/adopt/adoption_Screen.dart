import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebnak1/Screens/adopt/child_details_screen.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/adoption_model.dart';
import '../../shared/re_useable_components.dart';

class adoptionScreen extends StatelessWidget {

  List <Color>Colorsx = [
    const Color(0xFFC5FFC2),
    const Color(0xFFB6CFFF),
    const Color(0xFFDDB6FF),
    const Color(0xFFFFC9C9),
    const Color(0xFFC9FFF8),
    const Color(0xFFF8FFB2),
  ];

  adoptionScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);


    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Column(
              children: [
                Text('Location',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconBroken.Location, size: 20, color: Colors.black54,),
                    SizedBox(
                      width: getProportionateScreenWidth(3),
                    ),
                    Text('Shiekh Zayed City',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20
                      ),),
                  ],
                ),


              ],
            ),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20,),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Container(
                  color: Color(0xFFF9F9F9),
                  child: Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Theme(
                          data: ThemeData(
                            inputDecorationTheme: InputDecorationTheme(
                              border: InputBorder.none,

                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                focusColor: kPrimaryColor,
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(IconBroken.Search,
                                  color: kPrimaryColor,),
                                hintText: 'Search for children...',

                              ),

                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),

                      ),

                      ListView.separated(

                          itemBuilder: (context, index) {
                           return  InkWell(
                               onTap: () {
                                 navigateTo(
                                   context,
                                   ChildDetailsScreen(EbnakCubit.get(context).childDetails[index]),
                                 );
                               },
                               child: buildChildItem(EbnakCubit.get(context).childDetails[index], context, index));

                          },

                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),


                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: getProportionateScreenHeight(40),
                              ),

                          itemCount: EbnakCubit.get(context).childDetails.length),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      )

                    ],
                  ),

                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget buildChildItem(AdoptModel model, context, index) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: getProportionateScreenHeight(180),
                width: getProportionateScreenWidth(180),
                color: Colorsx[index],
                child: CachedNetworkImage(
                  imageUrl: '${model.image}',),

              ),

            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Container(
                  height: getProportionateScreenHeight(150),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('${model.name}',

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,


                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45, top: 5),
                            child: Icon(
                              Icons.male,
                              color: Colors.grey[400],
                              size: 30,

                            ),
                          ),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 5),
                        child: Row(
                          children: [
                            Text('${model.hobbies}',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5),),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,),
                        child: Row(
                          children: [
                            Text('${model.dateOfBirth}',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 11
                              ),),
                          ],
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5),),
                      Padding(
                        padding: const EdgeInsets.only(left: 6, top: 7),
                        child: Row(
                          children: [

                            Icon(
                              IconBroken.Location,
                              size: 17,
                              color: Colors.grey[500],
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(2),

                            ),
                            Text('${model.orghanageName} ',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11
                              ),),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      );
}