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
}
