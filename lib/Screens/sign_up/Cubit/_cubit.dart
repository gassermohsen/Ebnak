import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '_state.dart';


class EbnakRegisterCubit extends Cubit<EbnakRegisterStates> {
  EbnakRegisterCubit() : super(EbnakRegisterInitialState());

  static EbnakRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    // required String name,
    required String email,
    required String password,
    required String name,
    required String address,
    required String phone,
    required String DateOfBirth,
    bool? haveChildren,
    String? image,
    // required String phone,
  }) {
    print('hello');

    emit(EbnakRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(

        email: email,
        password: password)
        .then((value){

          print(value.user?.email);
          print(value.user?.uid);

          userCreate(
              name: name,
              email: email,
              address: address,
              phone: phone,
              DateOfBirth: DateOfBirth,
              uID: value.user!.uid,
              haveChildren: haveChildren,

          );

    })
        .catchError((error){

      emit(EbnakRegisterErrorState(
        error.toString()
      ));

    });

  }


  void userCreate({
    required String name,
    required String email,
    required String address,
    required String phone,
    required String DateOfBirth,
    required String uID,
     bool? haveChildren,
  }){
    EbnakUserModel model = EbnakUserModel(
        name: name,
        email: email,
        address: address,
        phone: phone,
        uID: uID,
        dateOfBirth: DateOfBirth,
        haveChildren: haveChildren,
        bio: 'Write your bio...',
        image:'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1649944776~exp=1649945376~hmac=157eb91436e445663bdc46c63e8de8f23df6eea8325c17b5bee1d5300beffb66&w=740',
    );
    FirebaseFirestore.instance.collection(
      'users'
    ).doc(uID)
     .set(model.toMap()).
    then((value) {
      emit(EbnakCreateUserSuccessState(uID));
    }).
    catchError((onError){
      emit(EbnakCreateUserErrorState(onError.toString()));
    });
  }

}
