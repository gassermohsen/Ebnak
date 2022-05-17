import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/Screens/Home/home_Screen.dart';
import 'package:ebnak1/Screens/adopt/adoption_Screen.dart';

import 'package:ebnak1/Screens/community/community_Screen.dart';
import 'package:ebnak1/Screens/missing/missing_Screen.dart';
import 'package:ebnak1/Screens/profile/profile_screen.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/models/adoption_model.dart';
import 'package:ebnak1/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../Screens/adopt/repository/adoption_repository.dart';
import '../../../Screens/community/community_Screen_test.dart';
import '../../../Screens/community/community_screen_test2.dart';
import '../../../models/addFace_model.dart';
import '../../../models/reportMissing_model.dart';
import '../../../models/user_model.dart';
import 'ebnak_states.dart';
import 'package:http/http.dart' as http ;

class EbnakCubit extends Cubit<EbnakStates>
{
  // final adoptionRepository? adoptRepositroy;

  EbnakCubit() : super(EbnakInitialState());

  static EbnakCubit get(context) => BlocProvider.of(context);



EbnakUserModel? userModel;


  void getUserData() {
    emit(EbnakGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = EbnakUserModel.FromJson(value.data()!);
      emit(EbnakGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(EbnakGetUserErrorState(error.toString()));
    });
  }
  
  
  
  
  
  

   int currentIndex=0;
   List<Widget>screens=[
     HomeScreen(),
     adoptionScreen(),
     communityScreentest2(),
     missingScreen(),
     profileScreen(),
   ];

   List<String>titles=[
     'Home',
     'Adopt',
     'Community',
     'Missing',
     'Profile',
   ];

   void changeBottomNav(int index){
     currentIndex= index;
     emit(EbnakChangeBottomNavState());
   }



  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {

    final  XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      print(pickedImage.path);
      emit(EbnakProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(EbnakProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String address,
    required String phone,
    required String bio,
}){
    emit(EbnakUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            // emit(EbnakUploadProfileImageSuccessState());
            print(value);
            updateUser
              (name: name,
                address: address,
                phone: phone,
                bio: bio,
                image: value,
            );
          }).catchError((onError){
            emit(EbnakUploadProfileImageErrorState());
          });
    })
        .catchError((onError){
      emit(EbnakUploadProfileImageErrorState());

    });
  }


//   void updateUserImage({
//     required String name,
//     required String address,
//     required String phone,
//     required String bio,
// }){
//     emit(EbnakUserUpdateLoadingState());
//   if(profileImage!=null){
//     uploadProfileImage();
//   }else{
//     updateUser(
//         name: name, address: address, phone: phone, bio: bio);
//
//   }
//
//
//   }

  void updateUser({
    required String name,
    required String address,
    required String phone,
    required String bio,
    String? image,
}){


    EbnakUserModel model =EbnakUserModel(
      phone: phone,
      address: address,
      name: name,
      bio:bio,
      email: userModel?.email,
      haveChildren: userModel?.haveChildren,
      image: image?? userModel?.image,
      dateOfBirth: userModel?.dateOfBirth,
      uID: userModel?.uID,
    );


    FirebaseFirestore.instance.collection('users')
        .doc(userModel?.uID)
        .update(
        model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((onError){
      emit(EbnakUserUpdateErrorState());
    });

  }




  File? postImage;

  Future<void> getPostImage() async {

    final  XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      print(pickedImage.path);
      emit(EbnakPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(EbnakPostImagePickedErrorState());
    }
  }

  void removePostImage(){
    postImage=null;
    emit(EbnakRemovePostImageState());
  }


  void UploadPostImage({
    required String? dateTime,
    required String? text,
  }){
    emit(EbnakCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(EbnakUploadProfileImageSuccessState());
        print(value);
        createPost(
            dateTime: dateTime,
            postImage: value,
            text: text);



      }).catchError((onError){
        emit(EbnakCreatePostErrorState());
      });
    })
        .catchError((onError){
      emit(EbnakCreatePostErrorState());

    });
  }





  void createPost({

    required String? dateTime,
    required String? text,
    String? postImage,
  }){

    emit(EbnakCreatePostLoadingState());



    PostModel model =PostModel(

      name: userModel!.name,
      text: text,
      dateTime: dateTime,
      postImage: postImage??'',
      email: userModel?.email,
      image: userModel?.image,
      uID: userModel?.uID,
    );


    FirebaseFirestore.instance.collection('posts')
        .add(
        model.toMap())
        .then((value) {
          emit(EbnakCreatePostSuccessState());
    })
        .catchError((onError){
      emit(EbnakCreatePostErrorState());
    });

  }


   List<PostModel>posts=[];
  List<String>PostsIds=[];
  List<int>Likes=[];

  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              Likes.add(value.docs.length);
              PostsIds.add(element.id);
              posts.add(PostModel.FromJson(element.data()));
            })
            .catchError((onError){});

          });
      emit(EbnakGetPostsSuccessState());

    })
        .catchError((onError){
          emit(EbnakGetPostsErrorState(onError.toString()));
    });
  }

  //
  // Stream<List<PostModel>>? getPosts2(){
  //    FirebaseFirestore.instance
  //       .collection('posts')
  //       .snapshots()
  //       .listen((event) {
  //     event.docs.forEach((element) {
  //       element.reference
  //           .collection('likes')
  //           .snapshots()
  //           .listen((event) {
  //
  //         Likes.add(event.docs.length);
  //         PostsIds.add(element.id);
  //         posts.add(PostModel.FromJson(element.data()));
  //
  //       });
  //
  //       });
  //     emit(EbnakGetPostsSuccessState());
  //
  //   });
  // }






  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uID)
         .set({
           'like': true,
          })
        .then((value) {
          emit(EbnakLikePostSuccessState());
    })
        .catchError((onError){
          emit(EbnakLikePostErrorState(onError.toString()));
    });
  }




   Stream<QuerySnapshot>? getallposts2(){
      FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((event) {
          Likes=[];
          PostsIds=[];

           event.docs.forEach((element) {

            element.reference.collection('likes')
                .snapshots()
                .listen((event) {


                      Likes.add(event.docs.length);
                      PostsIds.add(element.id);
                      posts.add(PostModel.FromJson(element.data()));



            });
          });
    });
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> trytogetPosts() {

    return FirebaseFirestore.instance
        .collection('posts')
        .snapshots();



  }
  void addFunction(){
      trytogetPosts().listen((event) {

        posts=[];
        Likes=[];
        event.docs.forEach((element) {


        element.reference.collection('likes')
            .snapshots()
            .forEach((event) {


          Likes.add(event.docs.length);
          PostsIds.add(element.id);
          posts.add(PostModel.FromJson(element.data()));

        });


      });





      });

  }



  File? reportMissingImage;

  Future<void> getreportMissingImage() async {

    final  XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      reportMissingImage = File(pickedImage.path);
      print(pickedImage.path);
      emit(EbnakReportMissingImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(EbnakReportMissingImagePickedErrorState());
    }
  }



  void removeReportImage(){
    reportMissingImage=null;
    emit(EbnakRemoveReportImageState());
  }

  addFaceModel? faceModel;
   late reportMissingModel reportModel;
  late String reportID;
  void createReport({

    required String? dateTime,
    required String? fullName,
    required String? Age,
    required String? Info,
    required String? MissingAddress,
    required String? reportID,
    required String? persistedFaceId,






    String? reportMissingImage,
  }){

    emit(EbnakCreateReportLoadingState());



    reportModel =reportMissingModel(
      fullName: fullName,
      Age:Age ,
      MissingAddress: MissingAddress,
      Information: Info,
      reportMissingImage:reportMissingImage??'' ,
      name: userModel!.name,
      dateTime: dateTime,
      email: userModel?.email,
      image: userModel?.image,
      uID: userModel?.uID,
      phoneNumber: userModel?.phone,
      reportID: reportID,
      persistedFaceId: persistedFaceId


    );


    FirebaseFirestore.instance.collection('Reports')
        .add(
        reportModel.toMap())
        .then((value)  {
      reportModel.reportID==value.id;
      reportID = value.id;

      print(reportID);
          FirebaseFirestore.instance.collection('Reports')
          .doc(value.id)
          .update({
            'reportID': value.id,
           'persistedFaceId':faceModel?.persistedFaceId
          });
      emit(EbnakCreateReportSuccessState());
    })
        .catchError((onError){
      emit(EbnakCreateReportErrorState());
    });

  }



  void UploadReportImage({
    required String? dateTime,
    required String? fullName,
    required String? Age,
    required String? Info,
    required String? MissingAddress,
  }){
    emit(EbnakCreateReportLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Reports/${Uri.file(reportMissingImage!.path).pathSegments.last}')
        .putFile(reportMissingImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)async {
        // emit(EbnakUploadProfileImageSuccessState());
        print(value);
        await addFace(value);
        createReport(
            dateTime: dateTime,
            reportMissingImage: value,
            fullName: fullName,
          MissingAddress: MissingAddress,
           Info: Info,
            Age: Age,
          reportID: '',
          persistedFaceId:'',
        );




      }).catchError((onError){
        emit(EbnakCreateReportErrorState());
      });
    })
        .catchError((onError){
      emit(EbnakCreateReportErrorState());

    });
  }
Future<addFaceModel?> addFace(
    String? url,

    )async{
  var headers = {
    'Content-Type': 'application/json',
    'Ocp-Apim-Subscription-Key': '8f1f397a90dc4a87856c9a4f5dad4b98'
  };
  var request = http.Request('POST', Uri.parse('https://childarity.cognitiveservices.azure.com/face/v1.0/largefacelists/ebnak_01/persistedfaces?detectionModel=detection_03'));
  request.body = json.encode({
    "url": url
  });
  request.headers.addAll(headers);

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {

    print(await response.body.toString());
    faceModel=addFaceModel.FromJson(jsonDecode(response.body));
    print(faceModel?.persistedFaceId);
  }
  else {
    print(response.reasonPhrase);
  }
  return null;
  }



  File? DetectionImage;

  Future<void> getDetectionImage() async {

    final  XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      DetectionImage = File(pickedImage.path);
      print(pickedImage.path);
      emit(EbnakDetectionImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(EbnakDetectionImagePickedErrorState());
    }
  }



  void removeDetectionImage(){
    DetectionImage=null;
    emit(EbnakRemoveDetectionImageState());
  }





}






// Stream<QuerySnapshot<Map<String, dynamic>>> trytogetPosts() {
//   return  FirebaseFirestore.instance
//       .collection('posts')
//       .snapshots()
//
//   ;
// }



