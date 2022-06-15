import 'dart:async';
import 'dart:convert';
import 'dart:core' as core;
import 'dart:core';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/Screens/Home/home_Screen.dart';
import 'package:ebnak1/Screens/adopt/adoption_Screen.dart';
import 'package:ebnak1/Screens/missing/missing_Screen.dart';
import 'package:ebnak1/Screens/profile/profile_screen.dart';
import 'package:ebnak1/constants/constants.dart';
import 'package:ebnak1/models/adoption_model.dart';
import 'package:ebnak1/models/findSimilar_model.dart';
import 'package:ebnak1/models/post_model.dart';
import 'package:ebnak1/models/shortArticles_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../Screens/community/community_Screen_test.dart';
import '../../../models/addFace_model.dart';
import '../../../models/addMember_model.dart';
import '../../../models/articles_model.dart';
import '../../../models/comment_model.dart';
import '../../../models/detectFace_model.dart';
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

  void LogOut(){
    emit(EbnakLogOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      // userModel?.image='';
      // userModel?.name='';
      // userModel?.dateOfBirth='';
      // userModel?.email='';
      // userModel?.uID='';
      // userModel?.address='';
      // userModel?.haveChildren=false;
      // userModel?.phone='';
      // userModel?.bio='';

      emit(EbnakLogOutSuccessState());
    }).catchError((onError){
      emit(EbnakLogOutErrorState());
    });
  }
  
  
  
  
  
  

   int currentIndex=0;
   List<Widget>screens=[
     HomeScreen(),
     adoptionScreen(),
     communityScreentest(),
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


  File? memberImage;
  ImagePicker memberPicker = ImagePicker();

  Future<void> getMemberImage() async {

    final  XFile? pickedImage = await memberPicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      memberImage = File(pickedImage.path);
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
    String? postID,
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
      postID: postID,
    );


    FirebaseFirestore.instance.collection('posts')
        .add(
        model.toMap())
        .then((value) {
          FirebaseFirestore.instance.collection('users').doc(uId).collection('userposts').add(model.toMap());
          FirebaseFirestore.instance.collection('posts')
              .doc(value.id)
              .update({
            'postID': value.id,
          });

          emit(EbnakCreatePostSuccessState());
    })
        .catchError((onError){
      emit(EbnakCreatePostErrorState());
    });

  }

  void deletePost({
   String? postID
}){
    emit(EbnakDeletePostLoadingState());

    FirebaseFirestore.instance.collection('posts').doc(postID).delete().then((value) {
      emit(EbnakDeletePostSuccessState());

    }).catchError((onError){
      emit(EbnakDeletePostErrorState());
    });

}




  void UpdatePost({
    String? postID,
    String? text
  }){
    emit(EbnakUpdatePostLoadingState());

    FirebaseFirestore.instance.collection('posts').doc(postID).update({
    'text':text
    }
    ).then((value) {
      emit(EbnakUpdatePostSuccessState());

    }).catchError((onError){
      emit(EbnakUpdatePostErrorState());
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


  List<commentModel> commentmodel=[];

  void CommentPost({required String postId,required String comment, required String? time}){

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'comment':comment,
      'name':userModel?.name,
      'userID':userModel?.uID,
      'userImage':userModel?.image,
      'userEmail':userModel?.email,
      'time':time,
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
        .orderBy('dateTime',descending: true)
        .snapshots();
  }

  List<PostModel>Userposts=[];
  List<String>UserPostsIds=[];
  List<int>UserLikes=[];
  List<commentModel> Usercommentmodel=[];


  Stream<QuerySnapshot<Map<String, dynamic>>> trytogetUserPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('uID',isEqualTo:uId)
        .orderBy('dateTime',descending: true)
        .snapshots();
  }

  Future getLikes()async{

    for(int i=0;i<posts.length;i++){
         FirebaseFirestore.instance.collection('posts')
        .doc(PostsIds[i])
        .collection('likes')
        .get()
        .then((event) {
          Likes=[];
       Likes.add(event.docs.length);
       print(event.docs.length);
    });
    }
  }
  void addFunction(){
      trytogetPosts().listen((event) {

        posts=[];
        Likes=[];
        PostsIds=[];
        event.docs.forEach((element) {
        element.reference.collection('likes')
            .snapshots()
            .listen((value) {
          Likes.add(value.docs.length);
        });
        posts.add(PostModel.FromJson(element.data()));
        PostsIds.add(element.id);


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
    required GeoPoint? currentLocation,





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
      persistedFaceId: persistedFaceId,
      location: currentLocation,


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

      FirebaseFirestore.instance.collection('users').doc(uId).collection('userreports').add(reportModel.toMap()).then((value2){
        FirebaseFirestore.instance.collection('users').doc(uId).collection('userreports').doc(value2.id).update({
          'reportID': value.id,
          'persistedFaceId':faceModel?.persistedFaceId
        });
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
    required GeoPoint? currentLocation,
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
          currentLocation: currentLocation,
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
    'Ocp-Apim-Subscription-Key': Subscription_Key,
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




  // Detection Section

  DetectFaceModel? DetectModel;

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





  Future trainList()async{
    var headers = {
      'Ocp-Apim-Subscription-Key': Subscription_Key
    };
    var request = http.Request('POST', Uri.parse('https://childarity.cognitiveservices.azure.com/face/v1.0/largefacelists/ebnak_01/train'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('List Trained Successfully');
      emit(EbnakListTrainedSuccessState());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }


  void UploadDetectionImage(){


    emit(EbnakDetectionLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Detection/${Uri.file(DetectionImage!.path).pathSegments.last}')
        .putFile(DetectionImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)async {
        // emit(EbnakUploadProfileImageSuccessState());
        print(value);
         trainList();
        await detectFace(value);
        await FindSimilar(DetectModel?.faceId);
        getDetection();



      }).catchError((onError){
        print(onError.toString());
        emit(EbnakDetectionErrorState());
      });
    })
        .catchError((onError){
      print(onError.toString());

      emit(EbnakDetectionErrorState());

    });


  }


  Future <DetectFaceModel?>detectFace(

      String? url,
      )async{

emit(EbnakFaceDetectLoadingState());
    var headers = {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': Subscription_Key
    };
    var request = http.Request('POST', Uri.parse('https://childarity.cognitiveservices.azure.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&recognitionModel=recognition_04&returnRecognitionModel=false&detectionModel=detection_03&faceIdTimeToLive=86400'));
    request.body = json.encode({
      "url": url
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      emit(EbnakFaceDetectSuccessState());

      print(await response.body.toString());
      final responsebody=json.decode(response.body);

      DetectModel=DetectFaceModel.fromJson(responsebody[0]);
      print(DetectModel?.faceId);
    }
    else {
      print(response.reasonPhrase);
      emit(EbnakFaceDetectErrorState());

    }

  }


List<FindSimilarModel> findSimilarModel=[];

  Future FindSimilar(
      String? faceID,
      )async{
emit(EbnakFindSimilarLoadingState());

    var headers = {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': Subscription_Key
    };
    var request = http.Request('POST', Uri.parse('https://childarity.cognitiveservices.azure.com/face/v1.0/findsimilars'));
    request.body = json.encode({
      "faceId": faceID,
      "largeFaceListId": "ebnak_01",
      "maxNumOfCandidatesReturned": 1,
      "mode": "matchPerson"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      emit(EbnakFindSimilarSuccessState());

      print(await response.body.toString());
      List responsebody=json.decode(response.body);
      for(int i=0;i<1;i++){
      findSimilarModel= responsebody.map((face) => new FindSimilarModel.fromJson(face)).toList() ;
      }


      print(findSimilarModel[0].persistedFaceId);
      print(findSimilarModel[0].confidence);
    }
    else {
      emit(EbnakFindSimilarErrorState());

      print(response.reasonPhrase);
    }
    
  }



 late List<reportMissingModel>getDetectionInfo;


  
  void getDetection(){
    emit(EbnakGetDetectedLoadingState());
      FirebaseFirestore.instance.collection('Reports').where(
          "persistedFaceId", whereIn: [findSimilarModel[0].persistedFaceId,])
          .get()
          .then((value) {
        emit(EbnakGetDetectedSuccessState());
        getDetectionInfo = [];
        value.docs.forEach((element) {
          getDetectionInfo.add(reportMissingModel.FromJson(element.data()));
          print(getDetectionInfo.length);
        });
      }).catchError((onError) {
        emit(EbnakGetDetectedErrorState());
        print(onError);
      });

  }




  Map<String, int> postsLikesbymap = ({});

  Future<void> getAllposts() async{

    PostsIds=[];
    posts=[];
    postsLikesbymap = ({});
    emit(EbnakGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts')
    .orderBy('dateTime')
    .get()
    .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postsLikesbymap.addAll({element.id: value.docs.length});
          PostsIds.add(element.id);
        });
        posts.add(PostModel.FromJson(element.data()));
        emit(EbnakGetPostsSuccessState());

      });
    }).catchError((onError){
      emit(EbnakGetPostsErrorState(onError));
    });


  }


  void getSinglePost(String postId) {
    emit(EbnakGetSinglePostsLoadingState());
    FirebaseFirestore.instance.collection('posts')
    .doc(postId)
    .get()
    .then((value) {
      value.reference.collection('Likes').get().then((value) {
        postsLikesbymap[postId] = value.docs.length;

    });
  }).catchError((onError){
    emit(EbnakGetSinglePostsErrorState(onError));
    });
    }


    List<AdoptModel> childDetails=[];
  
  void getChildDeatils(){
    FirebaseFirestore.instance.collection('adoption')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            childDetails.add(AdoptModel.FromJson(element.data()));
          });

    });
  }

List<reportMissingModel>Reports=[];
  void getReportDeatils(){
    FirebaseFirestore.instance.collection('Reports')
        .snapshots()
        .listen((value) {
          Reports=[];
      value.docs.forEach((element) {
        Reports.add(reportMissingModel.FromJson(element.data()));
      });
      print(Reports.length);
    });
  }

  List<reportMissingModel>UserReports=[];
  void getUserReports(){
    FirebaseFirestore.instance.collection('Reports')
        .where('uID',isEqualTo: uId)
        .snapshots()
        .listen((value) {
      UserReports=[];
      value.docs.forEach((element) {
        UserReports.add(reportMissingModel.FromJson(element.data()));
      });
      print(UserReports.length);
    });
  }



  void DeleteReport({
    String? ReportID,
    String? PresistedFace,
  }){
    emit(EbnakDeleteReportLoadingState());
    FirebaseFirestore.instance.collection('Reports')
        .doc(ReportID)
        .delete()
        .then((value)  {
       DeletePresistedFace(PresistedFace);
      emit(EbnakDeleteReportSuccessState());

    }).catchError((onError){
      emit(EbnakDeleteReportErrorState());
    });
  }

  Future DeletePresistedFace(
      String? presistedFace,
      )async{
    var headers = {
      'Ocp-Apim-Subscription-Key': Subscription_Key
    };
    var request = http.Request('DELETE', Uri.parse('https://Childarity.cognitiveservices.azure.com/face/v1.0/largefacelists/ebnak_01/persistedfaces/${presistedFace}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<articlesModel>articleModel=[];


  void getArticles(){
    FirebaseFirestore.instance.collection('articles').get().then((value) {
      value.docs.forEach((element) {
        articleModel.add(articlesModel.FromJson(element.data()));
      });
    });
  }

  List<shortArticlesModel>shortArticleModel=[];


  void getShortArticles(){
    FirebaseFirestore.instance.collection('shortArticles').get().then((value) {
      value.docs.forEach((element) {
        shortArticleModel.add(shortArticlesModel.FromJson(element.data()));
      });
    });
  }



  late addMemberModel memberModel;
  late String memberID;

  Future createMember({

    required String? fullName,
    required String? Age,
    required String? Info,
    required String? memberID,
    required String? height,
    required String? weight,

    String? memberImage,
  }){

    emit(EbnakCreateMemberLoadingState());



    memberModel =addMemberModel(
      fullName: fullName,
      Age:Age ,
      Information: Info,
      memberImage:memberImage??'' ,
      name: userModel!.name,
      email: userModel?.email,
      image: userModel?.image,
      uID: userModel?.uID,
      phoneNumber: userModel?.phone,
      memberID: memberID,
      weight: weight,
      height: height,



    );


  return  FirebaseFirestore.instance.collection('usersMembers')
        .add(
        memberModel.toMap())
        .then((value)  {
      memberModel.memberID==value.id;
      memberID = value.id;

      print(memberID);
      FirebaseFirestore.instance.collection('usersMembers')
          .doc(value.id)
          .update({
        'memberID': value.id,
      });

      FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').add(memberModel.toMap()).then((value2){
        FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').doc(value2.id).update({
          'memberID': value2.id,
        });
      });


      emit(EbnakCreateMemberSuccessState());
    })
        .catchError((onError){
      emit(EbnakCreatememberErrorState());
    });

  }



  Future UploadMemberImage({
    required String? fullName,
    required String? Age,
    required String? Info,
    required String? height,
    required String? weight,
  }){
    emit(EbnakCreateMemberLoadingState());
  return  firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersMembers/${Uri.file(memberImage!.path).pathSegments.last}')
        .putFile(memberImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)async {
        // emit(EbnakUploadProfileImageSuccessState());
        print(value);
       await createMember(
          fullName: fullName,
          Info: Info,
          Age: Age,
          memberID: '',
          height: height,
          weight: weight,
          memberImage: value,
        );




      }).catchError((onError){
        emit(EbnakCreateMemberSuccessState());
      });
    })
        .catchError((onError){
      emit(EbnakCreatememberErrorState());

    });
  }


  List<addMemberModel>userMembers=[];
  
  Future getuserMembers(){
    
   return FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get()
        .then((value){
       value.docs.forEach((element) {
         userMembers.add(addMemberModel.FromJson(element.data()));
       });
       print(userMembers[0].memberID);

  });
  }

  List<addMemberModel>userMembersForReport=[];

  void getuserMembersForReport(){
    emit(EbnakGetUserMembersLoadingState());
     FirebaseFirestore.instance.collection('users').doc(uId).collection('userMembers').get()
        .then((value){
       userMembersForReport=[];
      value.docs.forEach((element) {
        userMembersForReport.add(addMemberModel.FromJson(element.data()));
      });
          emit(EbnakGetUserMembersSuccessState());
    }).catchError((onError){
      emit(EbnakGetUserMembersErrorState());
     });
  }









  late reportMissingModel reportChildrenModel;
  late String reportChildID;
  addFaceModel? myChildfaceModel;

  Future<void> createReportmyChildren({

    required String? dateTime,
    required String? fullName,
    required String? Age,
    required String? Info,
    required String? MissingAddress,
    required String? reportID,
     String? persistedFaceId,
    required GeoPoint? currentLocation,

    required String? reportMissingImage,
  }) async {

    emit(EbnakCreateReportLoadingState());



    reportChildrenModel =reportMissingModel(
      fullName: fullName,
      Age:Age ,
      MissingAddress: userModel!.address,
      Information: Info,
      reportMissingImage:reportMissingImage??'',
      name: userModel!.name,
      dateTime: dateTime,
      email: userModel?.email,
      image: userModel?.image,
      uID: userModel?.uID,
      phoneNumber: userModel?.phone,
      reportID: reportID,
      persistedFaceId: persistedFaceId,
      location: currentLocation,


    );
    await addFace(reportMissingImage);

    FirebaseFirestore.instance.collection('Reports')
        .add(
        reportChildrenModel.toMap())
        .then((value)  {
      reportChildrenModel.reportID==value.id;
      reportChildID = value.id;

      print(reportChildID);
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






}





// Stream<QuerySnapshot<Map<String, dynamic>>> trytogetPosts() {
//   return  FirebaseFirestore.instance
//       .collection('posts')
//       .snapshots()
//
//   ;
// }



