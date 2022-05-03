import 'dart:convert';

import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();
  static final baseUrl = "https://thesis-api.onrender.com/v1/3dview/";
  
  static String buildFullPath(String path){
    return baseUrl+path;
  }

  static Future<dynamic> get({required String path, Map<String,dynamic>? params, Options? options}) async {
    String fullPath = buildFullPath(path);
    try {
      Response response = await _dio.get(fullPath,queryParameters: params, options: options);
      return response.data;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<dynamic> post({required String path, dynamic data, Options? options}) async {
    String fullPath = buildFullPath(path);
    try {
      Response response = await _dio.post(fullPath,data:data, options: options );
      return response.data;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<dynamic> put({required String path, dynamic data,  Options? options}) async {
    String fullPath = buildFullPath(path);
    try {
      Response response = await _dio.put(fullPath,data:data, options: options);
      return response.data;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}