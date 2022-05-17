import 'package:ebnak1/models/post_model.dart';

abstract class BasePostsRepository{
  Stream<List<PostModel>>getAllPosts();
}