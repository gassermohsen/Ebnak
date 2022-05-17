import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebnak1/Screens/community/repository/base_posts_repository.dart';
import 'package:ebnak1/models/post_model.dart';

class PostsRepository extends BasePostsRepository{
  final FirebaseFirestore _firebaseFirestore;
  PostsRepository({
    FirebaseFirestore? firebaseFirestore,}):_firebaseFirestore=firebaseFirestore ?? FirebaseFirestore.instance;


  @override
  Stream<List<PostModel>> getAllPosts() {

    return _firebaseFirestore.collection('posts')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => PostModel.fromSnapShot(doc)).toList();

    }
    );

  }

}