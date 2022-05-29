import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class MyProfileRepository {
  UserServices userServices = UserServices();

  Future<ObjectResponse<User>> getUserInfor(String? userId) => userServices.getUserById(id: userId);
}
