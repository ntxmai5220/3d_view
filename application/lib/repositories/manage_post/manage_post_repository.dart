import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class ManagePostRepository {
  final PostServices postServices = PostServices();

  Future<ListResponse<Post>> getPostFilter(
          {required Map<String, dynamic> params}) =>
      postServices.getPostWithFilter(params: params);

  Future deletePost({required String postId}) =>
      postServices.deletePost(id: postId);
}
