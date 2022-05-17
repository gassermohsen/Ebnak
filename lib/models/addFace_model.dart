class addFaceModel{

  String? persistedFaceId;
  addFaceModel({
    required this.persistedFaceId,
});
  addFaceModel.FromJson(Map<String,dynamic>json){
    persistedFaceId=json['persistedFaceId'];

  }

    Map<String,dynamic>toMap() {
    return {
      'persistedFaceId': persistedFaceId,};
  }
}