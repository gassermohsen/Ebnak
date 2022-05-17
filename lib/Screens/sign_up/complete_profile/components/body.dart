import 'package:ebnak1/Screens/sign_in/components/form_error.dart';
import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/components/default_Button.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'complete_profile_form.dart';

class CompleteProfileBody extends StatelessWidget {
  const CompleteProfileBody({Key? key}) : super(key: key);

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
                height: SizeConfig.screenHeight*0.02,
              ),
              Text(
                "Complete Profile",
                style: headingStyle,

              ),
              Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight*0.05,
              ),
              CompleteProfileForm(),
              SizedBox(
                height: getProportionateScreenHeight(30),),

              Text("By continuing you confirm that you agree \nwith our Terms and Conditions",textAlign: TextAlign.center,),



            ],
          ),
        ),
      ),
    );
  }
}


