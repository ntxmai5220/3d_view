import 'package:dio/dio.dart';

class DioRequest {
  late String path;
  Options? options;
  Map<String,dynamic>? params;
  dynamic body;
  String? optionPath;
  DioRequest({required this.path, this.options, this.params, this.body, this.optionPath});
}