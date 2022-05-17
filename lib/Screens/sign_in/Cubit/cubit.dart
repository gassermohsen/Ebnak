import 'package:bloc/bloc.dart';
import 'package:ebnak1/Screens/sign_in/Cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EbnakLoginCubit extends Cubit <EbnakLoginStates> {
  EbnakLoginCubit() : super(EbnakLoginInitialState());

  static EbnakLoginCubit get(context) => BlocProvider.of(context);

  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(EbnakLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(EbnakLoginSuccessState(value.user!.uid));
    })
        .catchError((error) {
      emit(EbnakLoginErrorState(error.toString()));
    });
  }
}