import 'dart:math';

class EbnakUserModel{

  late String name;
   late String? email;
  late String address;
  late String phone;
   late String? uID;
  late String? dateOfBirth;
   bool? haveChildren;
   String? image;
   String? bio;

  EbnakUserModel({
    required this.name,
     this.email,

    required this.address,
    required this.phone,
     this.uID,
     this.dateOfBirth,
     this.haveChildren,
    this.image,
    this.bio

});
  EbnakUserModel.FromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    address=json['address'];
    phone=json['phone'];
    image=json['image'];
    uID=json['uID'];
    bio=json['bio'];

    dateOfBirth=json['DateOfBirth'];
    haveChildren=json['haveChildren'];

  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'address':address,
      'phone':phone,
      'uID':uID,
      'bio':bio,
      'DateOfBirth':dateOfBirth,
      'haveChildren':haveChildren,
      'image':image,



    };
  }
}

