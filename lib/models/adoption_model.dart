import 'package:cloud_firestore/cloud_firestore.dart';

class AdoptModel{

  late String name;
  late String? dateOfBirth;
  late String? childID;
  late String? hobbies;
  late String? likes;
  late String? gender;
  late String? numberOfChildrenOrghanage;
  late String? orghanageLocation;
  late String? orghanageName;
  late String? orghanageAddress;
  String? image;
  String? fullDescription;

  AdoptModel({
    required this.name,
    this.dateOfBirth,

    this.childID,
    this.hobbies,
    this.likes,
    this.gender,
    this.numberOfChildrenOrghanage,
    this.orghanageLocation,
    this.orghanageName,
    this.orghanageAddress,
    this.image,
    this.fullDescription,



  });
  AdoptModel.FromJson(Map<String,dynamic>json){
    name=json['name'];
    dateOfBirth=json['dateofbirth'];
    childID=json['childID'];
    hobbies=json['Hobbies'];
    likes=json['Likes'];
    gender=json['gender'];
    numberOfChildrenOrghanage=json['numberofchildren'];
    orghanageLocation=json['orghanagelocation'];
    orghanageName=json['orghanagename'];
    orghanageAddress=json['orghanageaddress'];
    fullDescription=json['fulldescription'];
    image=json['image'];



  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'dateofbirth':dateOfBirth,
      'childID':childID,
      'Hobbies':hobbies,
      'Likes':likes,
      'gender':gender,
      'numberofchildren':numberOfChildrenOrghanage,
      'orghanagelocation':orghanageLocation,
      'orghanagename':orghanageName,
      'orghanageaddress':orghanageAddress,
      'fulldescription':fullDescription,
      'image':image,


    };
  }

  static AdoptModel fromSnapShot(DocumentSnapshot snap){
    AdoptModel adoptModel = AdoptModel(
      name: snap['name'],
      dateOfBirth: snap['dateofbirth'],
      childID: snap['childID'],
      hobbies: snap['Hobbies'],
      image: snap['image'],
      likes: snap['likes'],
      gender: snap['gender'],
      numberOfChildrenOrghanage: snap['numberofchildren'],
      orghanageLocation: snap['orghanagelocation'],
      orghanageName: snap['orghanagename'],
      orghanageAddress: snap['orghanageaddress'],
      fullDescription: snap['fulldescription'],

    );
    return adoptModel;
  }




  }