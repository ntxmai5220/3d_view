import 'dart:io';

import 'package:bk_3d_view/apis/apis.dart';
import 'package:dio/dio.dart';

class ApiExecute {
  final Dio _dio;
  BaseURL baseURL;

  ApiExecute({required this.baseURL})
      : _dio = Dio(BaseOptions(baseUrl: baseURL.url));

  Future<APIResponse> execute({required APIRequest request}) async {
    Options options = Options(
      contentType: Headers.jsonContentType,
      method: request.method.value,
      headers: request.headers,
    );

    try {
      Response response = await _dio.request(
        request.path,
        queryParameters: request.parameters,
        data: request.body,
        options: options,
      );

      return APIResponse.fromJson(response.data);
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
  }
}
