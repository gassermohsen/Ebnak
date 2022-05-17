import 'package:ebnak1/models/adoption_model.dart';

abstract class EbnakStates {}

class EbnakInitialState extends EbnakStates {}

class EbnakGetUserLoadingState extends EbnakStates {}

class EbnakGetUserSuccessState extends EbnakStates {}

class EbnakGetUserErrorState extends EbnakStates
{
  final String error;

  EbnakGetUserErrorState(this.error);
}

class EbnakChangeBottomNavState extends EbnakStates {}

class EbnakProfileImagePickedSuccessState extends EbnakStates {}

class EbnakProfileImagePickedErrorState extends EbnakStates {}



class EbnakUploadProfileImageSuccessState extends EbnakStates {}

class EbnakUploadProfileImageErrorState extends EbnakStates {}

class EbnakUserUpdateErrorState extends EbnakStates {}

class EbnakUserUpdateLoadingState extends EbnakStates {}


// create post
class EbnakCreatePostLoadingState extends EbnakStates {}
class EbnakCreatePostSuccessState extends EbnakStates {}
class EbnakCreatePostErrorState extends EbnakStates {}

class EbnakPostImagePickedSuccessState extends EbnakStates {}

class EbnakPostImagePickedErrorState extends EbnakStates {}

class EbnakRemovePostImageState extends EbnakStates {}



class EbnakGetPostsLoadingState extends EbnakStates {}

class EbnakGetPostsSuccessState extends EbnakStates {}

class EbnakGetPostsErrorState extends EbnakStates
{
  final String error;

  EbnakGetPostsErrorState(this.error);
}


class EbnakLikePostSuccessState extends EbnakStates {}

class EbnakLikePostErrorState extends EbnakStates
{
  final String error;

  EbnakLikePostErrorState(this.error);
}


class EbnakGetChildrenSuccessState extends EbnakStates {
  final  List<AdoptModel> adoptmodel;

  EbnakGetChildrenSuccessState(this.adoptmodel);
}

class EbnakGetChildrenErrorState extends EbnakStates
{
  final String error;

  EbnakGetChildrenErrorState(this.error);
}



class EbnakReportMissingImagePickedSuccessState extends EbnakStates {}

class EbnakReportMissingImagePickedErrorState extends EbnakStates {}


class EbnakRemoveReportImageState extends EbnakStates {}




// create Report
class EbnakCreateReportLoadingState extends EbnakStates {}
class EbnakCreateReportSuccessState extends EbnakStates {}
class EbnakCreateReportErrorState extends EbnakStates {}






class EbnakDetectionImagePickedSuccessState extends EbnakStates {}

class EbnakDetectionImagePickedErrorState extends EbnakStates {}


class EbnakRemoveDetectionImageState extends EbnakStates {}