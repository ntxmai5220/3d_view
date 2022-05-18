import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:dio/dio.dart';

class UserRequest{
  UserRequest._();

  // Path : user/:id
  static DioRequest getById({required String id, required String token }){
    Options options = OptionBuilder().authorizeToken(token).build();
    return DioRequest(path: "user/$id", options: options);
  }

}