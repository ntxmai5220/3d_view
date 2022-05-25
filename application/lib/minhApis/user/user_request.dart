import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:dio/dio.dart';

class UserRequest {
  UserRequest._();

  // Path : user/:id
  static DioRequest getUserById({
    required String id,
    String? token,
  }) {
    Options options =
        OptionBuilder().authorizeToken(token ?? 'example1').build();
    return DioRequest(
      path: "user/$id",
      options: options,
    );
  }

  static DioRequest getListFollowed({
    required String userId,
    required Map<String, dynamic> params,
    String? token,
  }) {
    Options options =
        OptionBuilder().authorizeToken(token ?? 'example1').build();
    return DioRequest(
      path: "user/listfollow/$userId",
      options: options,
      params: params,
    );
  }
}
