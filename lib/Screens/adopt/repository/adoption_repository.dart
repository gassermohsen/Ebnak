import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/models/post_model.dart';

import '../../../models/adoption_model.dart';

class adoptionRepository{
  late List<PostModel> postmodel;
  Stream<List<AdoptModel>> getAllChildren(){
    return FirebaseFirestore.instance
      .collection('adoption')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) =>AdoptModel.fromSnapShot(doc)).toList();
           });

}
}