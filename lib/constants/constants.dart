import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Size_config/size_config.dart';

 HexColor kPrimaryColor =  HexColor('#77D171');
const kPrimaryLightColor = Color(0xFFFFECDF);
 LinearGradient kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [ HexColor('#80FF77'),  HexColor('#41B639')],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle=  TextStyle(fontSize: getProportionateScreenWidth(28),
 fontWeight: FontWeight.bold,
 color: Colors.black,

);

final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

String Subscription_Key='8f1f397a90dc4a87856c9a4f5dad4b98';


String? uId = '';













