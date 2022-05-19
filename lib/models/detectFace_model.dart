class DetectFaceModel {
  String? faceId;
  FaceRectangle? faceRectangle;

  DetectFaceModel({this.faceId, this.faceRectangle});

  DetectFaceModel.fromJson(Map<String, dynamic> json) {
    faceId = json['faceId'];
    faceRectangle = json['faceRectangle'] != null
        ? new FaceRectangle.fromJson(json['faceRectangle'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faceId'] = this.faceId;
    if (this.faceRectangle != null) {
      data['faceRectangle'] = this.faceRectangle!.toJson();
    }
    return data;
  }
}

class FaceRectangle {
  int? top;
  int? left;
  int? width;
  int? height;

  FaceRectangle({this.top, this.left, this.width, this.height});

  FaceRectangle.fromJson(Map<String, dynamic> json) {
    top = json['top'];
    left = json['left'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['top'] = this.top;
    data['left'] = this.left;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
