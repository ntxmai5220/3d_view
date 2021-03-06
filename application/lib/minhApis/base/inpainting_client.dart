import 'package:dio/dio.dart';

class InPantingClient {
  static final Dio _dio = Dio();
  static const baseUrl = "https://api.phosus.com/inpaint/v1";

  static Future<dynamic> removeWithMask(
      {required dynamic data, Options? options}) async {
    try {
      Response response =
          await _dio.post(baseUrl, data: data, options: options);
      return response.data;
    } catch (e) {
      throw e.toString();
      // print(e.toString());
    }
    // return null;
  }
}
