import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:dio/dio.dart';

class UserRequest {
  UserRequest._();

  // Path : user/:id
  static DioRequest getUserById({String? id}) {
    Options options = OptionBuilder().authorizeToken().build();
    return DioRequest(
      path: "user/${id??HelperSharedPreferences.savedUserId}",
      options: options,
    );
  }

  static DioRequest getAllUser() {
    Options options = OptionBuilder().authorizeToken().build();
    return DioRequest(
      path: "user/",
      options: options,
    );
  }

  static DioRequest getListFollowed({
    required Map<String, dynamic> params,
  }) {
    Options options = OptionBuilder().authorizeToken().build();
    return DioRequest(
      path: "user/listfollow/${HelperSharedPreferences.savedUserId}",
      options: options,
      params: params,
    );
  }
}
