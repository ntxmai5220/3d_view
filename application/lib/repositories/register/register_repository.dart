import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class RegisterRepository {
  AuthServices authServices = AuthServices();

  Future<ObjectResponse<User>> signup({
    required String email,
    required String pw,
    required String name,
  }) =>
      authServices.signup(
        email: email,
        pw: pw,
        name: name,
      );
}
