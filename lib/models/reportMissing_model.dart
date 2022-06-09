
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class reportMissingModel{

  late String name;
  late String? email;
  late String? uID;
  String? reportID;
  late String? dateTime;
  String? image;
  String? fullName;
  String? Age;
  String? MissingAddress;
  String? Information;
  String? phoneNumber;
  String? persistedFaceId;
  GeoPoint? location;


 late String reportMissingImage;

  reportMissingModel({
    required this.name,
    this.email,

    this.fullName,
    required this.reportMissingImage,
    this.uID,
    this.dateTime,
    this.image,
    this.MissingAddress,
    this.Age,
    this.Information,
    this.reportID,
    this.phoneNumber,
    this.persistedFaceId,
    this.location
  });
  reportMissingModel.FromJson(Map<String,dynamic>?json){
    name=json?['name'];
    email=json?['email'];
    fullName=json?['fullName'];
    Age=json?['Age'];
    MissingAddress=json?['MissingAddress'];
    phoneNumber=json?['phoneNumber'];
    Information=json?['Information'];
    reportMissingImage=json?['reportMissingImage'];
    image=json?['image'];
    uID=json?['uID'];
    dateTime=json?['dateTime'];
    persistedFaceId=json?['persistedFaceId'];
    location=json?['location'];
    reportID=json?['reportID'];



  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'fullName':fullName,
      'Age':Age,
      'MissingAddress':MissingAddress,
      'phoneNumber':phoneNumber,
      'Information':Information,
      'reportMissingImage':reportMissingImage,
      'uID':uID,
      'dateTime':dateTime,
      'image':image,
      'persistedFaceId':persistedFaceId,
      'location':location,
      'reportID':reportID




    };
  }


  static reportMissingModel fromSnapShot(DocumentSnapshot snap){
    reportMissingModel postmodel = reportMissingModel(
      name: snap['name'],
      reportMissingImage: snap['reportMissingImage'],
      dateTime: snap['dateTime'],
      email: snap['email'],
      image: snap['image'],
      fullName: snap['fullName'],
      uID: snap['uID'],
      Age:snap['Age'],
    MissingAddress:snap['MissingAddress'],
    phoneNumber:snap['phoneNumber'],
    Information:snap['Information'],
      persistedFaceId:snap['persistedFaceId'],
      location: snap['location'],
      reportID:snap['reportID'],


    );
    return postmodel;
  }

}

