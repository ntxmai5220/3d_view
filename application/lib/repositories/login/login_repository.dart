import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class LoginRepository {
  final AuthServices authServices = AuthServices();

  Future<ObjectResponse<User>> login(
          {required String email, required String pw}) =>
      authServices.login(email: email, pw: pw);
}
