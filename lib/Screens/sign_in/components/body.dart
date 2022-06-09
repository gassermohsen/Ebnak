import 'dart:ui';

import 'package:ebnak1/Screens/sign_in/components/body.dart';
import 'package:ebnak1/Screens/sign_in/components/sign_form.dart';
import 'package:ebnak1/Screens/sign_in/components/social_card.dart';
import 'package:ebnak1/Screens/sign_up/sign_up_screen.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/components/default_Button.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/shared/re_useable_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'form_error.dart';

class SignInBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight*0.04,),

                Text("Welcome Back",style: TextStyle(color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold),
                ),
                Text("Sign in with your email and password  \nor continue with social media login",
                textAlign: TextAlign.center,

                ),
                SizedBox(height: SizeConfig.screenHeight*0.08,),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight*0.08,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(icon: "assets/icons/facebook-2.svg",
                      press: (){},),
                    SocialCard(icon: "assets/icons/google-icon.svg",
                      press: (){},),
                    SocialCard(icon: "assets/icons/twitter.svg",
                      press: (){},),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(fontSize: getProportionateScreenWidth(16)),),
                    GestureDetector(
                      onTap: ()=>navigateTo(context, SignUpScreen()),
                      child: Text("Sign Up",style: TextStyle(fontSize: getProportionateScreenWidth(16),
                          color: kPrimaryColor),) ,
                    )


                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}



