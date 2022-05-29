import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class FollowedRepository {
  final UserServices userServices = UserServices();
  final PostServices postServices = PostServices();

  Future<ListResponse<Post>> getListFollowed(
          {required Map<String, dynamic> params}) =>
      userServices.getListFollowed(params: params);

  Future<ObjectResponse<bool>> follow({
    required String postId,
    required bool isFavorite,
  }) =>
      postServices.follow(
        postId: postId,
        isFavorite: isFavorite,
      );
}
