
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/models/adoption_model.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/constants.dart';
import '../../styles/icon_broken.dart';

class ChildDetailsScreen extends StatelessWidget {
  final AdoptModel model;
   ChildDetailsScreen(this.model,  {Key? key}) : super(key: key);

  final double lat = 25.3622;
  final double lng = 86.0835;

  Future<void> launchMap() async {
    final String googleMapsUrl = "https:/www.google.com/maps/search/?api=1&query=$lat,$lng";

    if (await canLaunchUrlString(googleMapsUrl)) {
      await launchUrlString(googleMapsUrl);
    } else {
      throw "Error occured trying to call that number.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.green[100],
              statusBarIconBrightness: Brightness.dark,
            ),
            elevation: 0,

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: getProportionateScreenHeight(450),
                      color: Colors.green[100],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Image(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.3,
                          image: NetworkImage('${model.image}',

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 390),
                      child: Center(
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,

                            ),
                            width: getProportionateScreenWidth(320),
                            height: getProportionateScreenHeight(130),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18, left: 30),
                                      child: Text('${model.name}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600]
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 18),
                                      child: Icon(
                                        Icons.female,
                                        color: Colors.grey[500],
                                        size: 30,

                                      ),
                                    ),


                                  ],
                                ),
                                Container(
                                  width: getProportionateScreenWidth(320),
                                  child: Row(

                                      children: [

                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, left: 30),
                                          child: Text('${model.hobbies}',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: getProportionateScreenWidth(230),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 95),
                                                child: Text('${model.dateOfBirth}',
                                                  style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 11
                                                  ),),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, top: 15),
                                  child: Row(
                                    children: [

                                      Icon(
                                        IconBroken.Heart,
                                        size: 17,
                                        color: Colors.red[200],
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(3),

                                      ),
                                      Text('Likes : ${model.likes}',
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
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),


                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30
                ),),
                Text('Personal Information',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.green[100],
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Container(
                    width: double.infinity,
                    child: Text(

                        '${model.fullDescription}'
                      ,

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('Orphanage Information',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.green[100],
                    ),

                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Row(

                        children: [
                          Icon(
                            IconBroken.Home,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Text(
                            'Orphanage Name : ${model.orghanageName}',
                            style: TextStyle(
                                fontSize: 15
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                SizedBox(height: getProportionateScreenHeight(15),),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30),
                  child: Row(

                    children: [
                      Icon(
                        IconBroken.User1,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(5),
                      ),
                      Text(
                        'Number of children in the orghanage : ${model.numberOfChildrenOrghanage}',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Row(
                  children: [
                    CachedNetworkImage(
                      width: getProportionateScreenWidth(200),
                      imageUrl: 'https://img.freepik.com/free-vector/city-map-with-label-home-pin_1284-42340.jpg?t=st=1650423932~exp=1650424532~hmac=3db2dfddfc4d9465029fccfed50818ec9d27ffcf94d42a40a13246fe10e1af46&w=826',
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 30),
                          child: OutlinedButton(onPressed: () async {
                            launchMap();
                          },

                              child: Text('Locate Me',
                                style: TextStyle(color: Colors.black54),)
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,),
                          child: OutlinedButton(onPressed: () async {
                            String telephoneNumber = '01150168031';
                            String telephoneUrl = "tel:$telephoneNumber";

                            if (await canLaunchUrlString(telephoneUrl)) {
                              await launchUrlString(telephoneUrl);
                            } else {
                              throw "Error occured trying to call that number.";
                            }
                          },

                              child: Text('Contact Orghanage',
                                style: TextStyle(color: Colors.black54),)
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Container(
                  color: Colors.grey[100],
                  width: double.infinity,
                  height: getProportionateScreenHeight(80),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          width: getProportionateScreenWidth(70),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[100],
                          ),
                          child: IconButton(onPressed: () {},
                            icon: Icon(IconBroken.Heart, color: Colors.white,),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Container(
                            width: getProportionateScreenWidth(250),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green[100],
                            ),
                            child: TextButton(
                              onPressed: () async {
                                String email = 'this.is.tijani@gmail.com';
                                String subject = 'Ask For Appointment';
                                String body = 'More Details ';

                                String emailUrl = "mailto:$email?subject=$subject&body=$body";

                                if (await canLaunchUrlString(emailUrl)) {
                                  await launchUrlString(emailUrl);
                                } else {
                                  throw "Error occured sending an email";
                                };
                              },
                              child: Text('Ask For appointment',
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),),
                            )
                        ),
                      ),


                    ],
                  ),
                )


              ],
            ),
          ),


        );
      },
    );
  }
}
