import 'package:dio/dio.dart';

class InPantingClient {
  static final Dio _dio = Dio();
  static final baseUrl = "https://api.phosus.com/inpaint/v1";

  static Future<dynamic> removeWithMask({ required dynamic data , Options? options }) async {
    try {
      Response response = await _dio.post(baseUrl, data: data , options: options);
      return response.data;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}