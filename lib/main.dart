import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:ebnak1/Screens/Splash/splash_Screen.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_cubit.dart';
import 'package:ebnak1/layout/ebnak/cubit/ebnak_states.dart';
import 'package:ebnak1/main.dart';
import 'package:ebnak1/routs/routs.dart';
import 'package:ebnak1/shared/bloc_observer.dart';
import 'package:ebnak1/shared/cubit/cubit.dart';
import 'package:ebnak1/shared/cubit/states.dart';
import 'package:ebnak1/shared/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Screens/sign_in/sign_in_Screen.dart';
import 'constants/theme.dart';
import 'layout/ebnak/ebnak_layout.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  Widget widget;

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    print(uId);
    widget = EbnakLayout();
  } else
  {
    widget = SignInScreen();
  }


  BlocOverrides.runZoned(
        () {
          runApp(Ebnak(

            startWidget: widget,));

          // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );





}


class Ebnak extends StatelessWidget {
  final Widget startWidget;

  Ebnak({
    required this.startWidget
  });


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => AppCubit()

            ),
        BlocProvider(create: (context)=>EbnakCubit()..getUserData()..trytogetPosts()..getLikes()..getChildDeatils()..getReportDeatils()..trytogetUserPosts()..getUserReports()..getArticles()),

      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state){
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Ebnak',
    theme: theme(),
    home: startWidget,
    // initialRoute: SplashScreen.routeName,
    // routes: routes,


    );
    }
      ),
    );
  }
}





