import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class PostRepository {
  PostServices postServices = PostServices();

  Future<ObjectResponse<bool>> follow({
    required String postId,
    required bool isFavorite,
  }) =>
      postServices.follow(
        postId: postId,
        isFavorite: isFavorite,
      );
}
