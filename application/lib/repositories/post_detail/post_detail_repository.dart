import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class PostDetailRepository {
  PostServices postServices = PostServices();
  UserServices userServices = UserServices();
  Future<ObjectResponse<Post>> getPostDetail({required String id}) =>
      postServices.getPostDetail(id: id);

  Future<ObjectResponse<User>> getUserById({String? id}) =>
      userServices.getUserById(id: id);
}
