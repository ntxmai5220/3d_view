import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class AuthServices {
  Future<ObjectResponse<User>> login({
    required String email,
    required String pw,
  }) async {
    DioRequest request = AuthRequest.login(account: {
      'email': email,
      'password': pw,
    });

    APIResponse response = await DioClient.post(
      path: request.path,
      data: request.body,
      options: request.options,
    );

    User user = User.fromJson(response.data);
    print(user.toJson());

    return ObjectResponse(object: user);
  }

  Future<ObjectResponse<User>> signup({
    required String email,
    required String pw,
    required String name,
  }) async {
    DioRequest request = AuthRequest.signUp(account: {
      'email': email,
      'password': pw,
      'username': name,
    });

    APIResponse response = await DioClient.post(
      path: request.path,
      data: request.body,
      options: request.options,
    );

    User user = User.fromJson(response.data);
    return ObjectResponse(object: user);
  }
}
