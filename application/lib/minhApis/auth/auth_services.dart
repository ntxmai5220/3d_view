import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/models/user.dart';

class AuthServices {
  Future<ObjectResponse<User>> login(
      {required Map<String, String> account}) async {
    DioRequest request = AuthRequest.login(account: account);
    dynamic data = await DioClient.post(
        path: request.path, data: request.body, options: request.options);
    User user = User.fromJson(data);
    print(user.toJson());

    return ObjectResponse(object: user);
  }

  Future<ObjectResponse<User>> signup(
      {required Map<String, String> account}) async {
    DioRequest request = AuthRequest.signUp(account: account);
    dynamic data = await DioClient.post(
        path: request.path, data: request.body, options: request.options);
    User user = User.fromJson(data);
    return ObjectResponse(object: user);
  }
}