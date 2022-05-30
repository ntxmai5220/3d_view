import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class ListUserRepository {
  UserServices userServices = UserServices();

  Future<ListResponse<User>> getAllUser() => userServices.getAllUser();
}
