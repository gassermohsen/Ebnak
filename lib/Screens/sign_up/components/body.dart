import 'package:ebnak1/Screens/sign_in/components/form_error.dart';
import 'package:ebnak1/Screens/sign_up/components/sign_up_form.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/components/default_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../sign_in/components/sign_form.dart';
import '../../sign_in/components/social_card.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(
             height: SizeConfig.screenHeight*0.02,),

            Text(
                "Register Account",
                style:headingStyle,
              ),
              Text(
                "Complete your details or continue\nwith social media ",
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: SizeConfig.screenHeight*0.07,
              ),
              SignUpForm(),
              SizedBox(
                height: SizeConfig.screenHeight*0.07,
              ),
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
              Text(
                "By continuing you confirm that you agree\n with our Terms And Conditions",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}


