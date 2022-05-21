import 'dart:io';

import 'package:bk_3d_view/apis/apis.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();
  static const baseUrl = "https://thesis-api.onrender.com/v1/3dview/";

  static String buildFullPath(String path) {
    return baseUrl + path;
  }

  static Future<APIResponse> get(
      {required String path,
      Map<String, dynamic>? params,
      Options? options}) async {
    String fullPath = buildFullPath(path);
    try {
      Response response =
          await _dio.get(fullPath, queryParameters: params, options: options);
      return APIResponse.fromAppJson(response.data);
    } on DioError catch (e) {
      throw e.response?.statusMessage ??
          APIResponse.fromJson(e.response?.data).message ??
          'An unexpected error occurred.';
    } on SocketException catch (e) {
      throw e.message;
    } on HttpException catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
    // return null;
  }

  static Future<void> delete(
      {required String path,
      Map<String, dynamic>? params,
      Options? options}) async {
    String fullPath = buildFullPath(path);
    try {
      Response response =
          await _dio.delete(fullPath, queryParameters: params, options: options);
    } on DioError catch (e) {
      throw e.response?.statusMessage ??
          APIResponse.fromJson(e.response?.data).message ??
          'An unexpected error occurred.';
    } on SocketException catch (e) {
      throw e.message;
    } on HttpException catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
    // return null;
  }

  static Future<APIResponse> post(
      {required String path, dynamic data, Options? options}) async {
    String fullPath = buildFullPath(path);
    try {
      Response response =
          await _dio.post(fullPath, data: data, options: options);
      return APIResponse.fromAppJson(response.data);
    } on DioError catch (e) {
      print(e.toString());
      throw e.response?.statusMessage ??
          APIResponse.fromJson(e.response?.data).message ??
          'An unexpected error occurred.';
    } on SocketException catch (e) {
      throw e.message;
    } on HttpException catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
    // return null;
  }

  static Future<APIResponse> put(
      {required String path, dynamic data, Options? options}) async {
    String fullPath = buildFullPath(path);
    try {
      Response response =
          await _dio.put(fullPath, data: data, options: options);
          
      return APIResponse.fromAppJson(response.data);
    } on DioError catch (e) {
      throw e.response?.statusMessage ??
          APIResponse.fromJson(e.response?.data).message ??
          'An unexpected error occurred.';
    } on SocketException catch (e) {
      throw e.message;
    } on HttpException catch (e) {
      throw e.message;
    } on Exception catch (e) {
      throw e.toString();
    }
    // return null;
  }
}
