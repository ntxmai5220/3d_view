import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class UserServices {
  Future<ObjectResponse<User>> getUserById({required String id}) async {
    DioRequest request = UserRequest.getUserById(id: id);
    APIResponse data = await DioClient.get(
      path: request.path,
      options: request.options,
    );

    User user = User.fromJson(data.toObject());

    print(data.toObject());
    return ObjectResponse(object: user);
  }

  Future<ListResponse<Post>> getListFollowed(
      {required Map<String, dynamic> params}) async {
    DioRequest request = UserRequest.getListFollowed(
        userId: '625bd0648e18145a85211945', params: params);
    APIResponse response = await DioClient.get(
      path: request.path,
      options: request.options,
      params: request.params,
    );

    List<Post> list = response
        .toList()
        .map((post) => Post.fromJson(post, isFavorite: true))
        .toList();
    return ListResponse(list: list);
  }
}
