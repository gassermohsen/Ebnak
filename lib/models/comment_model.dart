import 'package:cloud_firestore/cloud_firestore.dart';

class commentModel{
  late String name;
  late String? userEmail;
  late String? userID;
  late String? time;
  String? userImage;
  String? comment;

  commentModel({
    required this.name,
    this.userEmail,
    this.comment,
    this.userID,
    this.time,
    this.userImage,

  });
  commentModel.FromJson(Map<String,dynamic>json){
    name=json['name'];
    userEmail=json['userEmail'];
    comment=json['comment'];
    userImage=json['userImage'];
    userID=json['userID'];
    time=json['time'];


  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'userEmail':userEmail,
      'comment':comment,
      'userID':userID,
      'time':time,
      'userImage':userImage,



    };
  }


  static commentModel fromSnapShot(DocumentSnapshot snap){
    commentModel commentmodel = commentModel(
      name: snap['name'],
      time: snap['time'],
      userEmail: snap['userEmail'],
      userImage: snap['userImage'],
      comment: snap['comment'],
      userID: snap['userID'],

    );
    return commentmodel;
  }

}
