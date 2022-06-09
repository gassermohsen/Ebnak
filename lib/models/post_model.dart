import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{

  late String name;
  late String? email;
  late String? uID;
  late String? dateTime;
  String? image;
  String? text;
  String? postImage;
  String? postID;

  PostModel({
    required this.name,
    this.email,

     this.text,
     this.postImage,
    this.uID,
    this.dateTime,
    this.image,
    this.postID,

  });
  PostModel.FromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    text=json['text'];
    postImage=json['PostImage'];
    image=json['image'];
    uID=json['uID'];
    dateTime=json['dateTime'];
    postID=json['postID'];


  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'text':text,
      'PostImage':postImage,
      'uID':uID,
      'dateTime':dateTime,
      'image':image,
      'postID':postID,



    };
  }


  static PostModel fromSnapShot(DocumentSnapshot snap){
    PostModel postmodel = PostModel(
      name: snap['name'],
      postImage: snap['PostImage'],
      dateTime: snap['dateTime'],
      email: snap['email'],
      image: snap['image'],
      text: snap['text'],
      uID: snap['uID'],
      postID: snap['postID'],

    );
    return postmodel;
  }

}

