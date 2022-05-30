import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class UserServices {
  Future<ObjectResponse<User>> getUserById({String? id}) async {
    DioRequest request = UserRequest.getUserById(id: id);
    APIResponse data = await DioClient.get(
      path: request.path,
      options: request.options,
    );

    User user = User.fromJson(data.toObject());

    return ObjectResponse(object: user);
  }

  Future<ListResponse<User>> getAllUser() async {
    DioRequest request = UserRequest.getAllUser();
    APIResponse response = await DioClient.get(
      path: request.path,
      options: request.options,
    );

    List<User> list =
        response.toList().map((item) => User.fromJson(item)).toList();

    return ListResponse(list: list);
  }

  Future<ListResponse<Post>> getListFollowed(
      {required Map<String, dynamic> params}) async {
    DioRequest request = UserRequest.getListFollowed(params: params);
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
