
import 'package:bk_3d_view/minhApis/apis.dart';

class UserServices{

  Future<dynamic> getById({required String id,required String token}) async {
    DioRequest request = UserRequest.getById(id: id, token: token);
    APIResponse data = await DioClient.get(
        path: request.path, options: request.options);
    print(data.toObject());
  }
}