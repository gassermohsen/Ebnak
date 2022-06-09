import 'package:ebnak1/Screens/sign_in/Cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Size_config/size_config.dart';
import 'Cubit/cubit.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => EbnakLoginCubit(),
      child: BlocConsumer<EbnakLoginCubit,EbnakLoginStates>(
        listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Sign in"),

              ),
              body: SignInBody(),
            );
          } ,

          )
    );
  }
}
