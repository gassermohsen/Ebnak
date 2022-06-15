
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class addMemberModel{

  late String name;
  late String? email;
  late String? uID;
  String? memberID;
  String? image;
  String? fullName;
  String? Age;
  String? Information;
  String? phoneNumber;
  String? height;
  String? weight;

  late String memberImage;

  addMemberModel({
    required this.name,
    this.email,

    this.fullName,
    required this.memberImage,
    this.uID,
    this.image,
    this.Age,
    this.Information,
    this.phoneNumber,
    this.height,
    this.memberID,
     this.weight,
  });
  addMemberModel.FromJson(Map<String,dynamic>?json){
    name=json?['name'];
    email=json?['email'];
    fullName=json?['fullName'];
    Age=json?['Age'];
    phoneNumber=json?['phoneNumber'];
    Information=json?['Information'];
    image=json?['image'];
    uID=json?['uID'];
    memberImage=json?['memberImage'];
    memberID=json?['memberID'];
    weight=json?['weight'];
    height=json?['height'];



  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'fullName':fullName,
      'Age':Age,
      'phoneNumber':phoneNumber,
      'Information':Information,
      'uID':uID,
      'image':image,
      'memberID':memberID,
      'memberImage':memberImage,
      'weight':weight,
      'height':height,





    };
  }


  static addMemberModel fromSnapShot(DocumentSnapshot snap){
    addMemberModel postmodel = addMemberModel(
      name: snap['name'],
      email: snap['email'],
      image: snap['image'],
      fullName: snap['fullName'],
      uID: snap['uID'],
      Age:snap['Age'],
      phoneNumber:snap['phoneNumber'],
      Information:snap['Information'],
      memberImage: snap['memberImage'],
      weight: snap['weight'],
      height: snap['height'],
      memberID: snap['memberID'],



    );
    return postmodel;
  }

}

