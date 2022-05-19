class FindSimilarModel {
  String? persistedFaceId;
  double? confidence;

  FindSimilarModel({this.persistedFaceId, this.confidence});

  FindSimilarModel.fromJson(Map<String, dynamic> json) {
    persistedFaceId = json['persistedFaceId'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['persistedFaceId'] = this.persistedFaceId;
    data['confidence'] = this.confidence;
    return data;
  }
}
