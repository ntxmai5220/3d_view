import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/minhApis/auth/authRequest.dart';
import 'package:bk_3d_view/models/user.dart';

class AuthServices {
  
  Future<dynamic> login({required Map<String, String> account}) async {
    DioRequest request = AuthRequest.login(account: account);
    dynamic data  = await DioClient.post(path: request.path, data: request.body, options: request.options);
    User user = User.fromJson(data);
    print(user.toJson());
  }

  Future<dynamic> signup({required Map<String, String> account}) async {
    DioRequest request = AuthRequest.signUp(account: account);
    dynamic data  = await DioClient.post(path: request.path, data: request.body, options: request.options);
    print(data);
  }
}