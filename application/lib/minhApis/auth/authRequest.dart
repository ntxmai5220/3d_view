import 'dart:convert';

import 'package:bk_3d_view/minhApis/base/DioRequest.dart';
import 'package:bk_3d_view/minhApis/base/OptionBuilder.dart';
import 'package:dio/dio.dart';

class AuthRequest {
    AuthRequest._();


    static DioRequest login({required Map<String, String> account}){
      Options options = OptionBuilder().jsonContent().build();
      return DioRequest(path: "auth/login", body: jsonEncode(account), options: options );
    }

    static DioRequest signUp({required Map<String, String> account}){
      Options options = OptionBuilder().jsonContent().build();
      return DioRequest(path: "auth/register", body: jsonEncode(account), options: options );
    }
}