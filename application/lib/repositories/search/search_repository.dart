import 'package:bk_3d_view/minhApis/apis.dart';

import 'package:bk_3d_view/models/models.dart';

class SearchRepository {

  final PostServices postServices = PostServices();

  Future<ListResponse<Post>> getPostFilter(
          {required Map<String, dynamic> params}) =>
      postServices.getPostWithFilter(params: params);

  Future<ObjectResponse<bool>> follow({
    required String postId,
    required bool isFavorite,
  }) =>
      postServices.follow(
        postId: postId,
        isFavorite: isFavorite,
      );
}
