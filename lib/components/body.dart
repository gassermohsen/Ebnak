import 'dart:ui';

import 'package:ebnak1/Size_config/size_config.dart';
import 'package:ebnak1/components/body.dart';
import 'package:ebnak1/components/default_Button.dart';
import 'package:ebnak1/components/splash_content.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/sign_in/sign_in_Screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String?,String?>>splashData=[
    {
      "image": "assets/images/Flying kite-pana.png",
      "text": "Welcome to Ebnak, Protect your children!",
    },
    {
      "image": "assets/images/Community-pana.png",
      "text": "Join our community to know more about your child",
    },
    {
      "image": "assets/images/Parents-pana.png",
      "text": "Ultimate way to protect your child from missing!",
    },

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                              (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer( flex: 3,),
                       DefaultButton(
                          text: "Continue",
                         press: (){
                            Navigator.pushNamed(context, SignInScreen.routeName);
                         },
                        ),

                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

