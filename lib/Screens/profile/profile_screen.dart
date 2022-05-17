import 'package:ebnak1/Screens/edit_profile/edit_profile_screen.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:ebnak1/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/default_Button.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<EbnakCubit, EbnakStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var userModel=EbnakCubit.get(context).userModel;
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: Container(
            color: Colors.white,
            height: getProportionateScreenHeight(350),
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      '${userModel?.image}'
                  ),
                ),
                Text(
                  '${userModel?.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 21
                  ),
                ),
                Text(
                  '${userModel?.bio}',
                  style: TextStyle(
                      color: Colors.grey[400]
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        elevation: 5,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        primary: kPrimaryColor,
                        fixedSize: Size(160, 40),
                      ),
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },


                      child: Text(
                        'Edit Profile', style: TextStyle(color: Colors.white),),


                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    TextButton(


                      style: TextButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Colors.grey[200],
                        fixedSize: Size(6, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),

                      ),

                      onPressed: () {},
                      child: Icon(IconBroken.Message,
                        color: Colors.grey[400],

                      ),


                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),

                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0,

                        ),

                        onPressed: () {},
                        label: Text('Posts',
                          style: TextStyle(
                              color: Colors.grey
                          ),),

                        icon: Icon(IconBroken.Category,
                          color: Colors.grey,)

                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(6),
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[300],
                          onSurface: kPrimaryColor,
                          side: BorderSide(
                              color: Colors.lightGreen.shade100
                          ),
                        ),

                        onPressed: null,
                        label: Text('My Reports',
                          style: TextStyle(
                              color: Colors.grey
                          ),),

                        icon: Icon(IconBroken.Danger,
                          color: Colors.grey,)

                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(6),
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0
                        ),

                        onPressed: () {},
                        label: Text('About',
                          style: TextStyle(
                              color: Colors.grey
                          ),),

                        icon: Icon(IconBroken.Profile,
                          color: Colors.grey,)

                    ),


                  ],
                )
              ],
            ),

          ),

        );
      },
    );
  }
}
