
import 'package:flutter/cupertino.dart';

import '../Screens/Splash/splash_Screen.dart';
import '../Screens/sign_in/sign_in_Screen.dart';
import '../Screens/sign_up/complete_profile/complete_profile_screen.dart';
import '../Screens/sign_up/sign_up_screen.dart';

final Map<String,WidgetBuilder>routes={
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName:(context)=>SignInScreen(),
  SignUpScreen.routeName:(context)=>SignUpScreen(),
  CompleteProfileScreen.routeName:(context)=>CompleteProfileScreen(emailController:'' , passwordController: '',),

};