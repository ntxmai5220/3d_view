import 'package:bk_3d_view/apis/apis.dart';

class APIRequest {
  APIRequest({
    required this.method,
    required this.path,
    this.parameters,
    this.body,
    this.headers,
  });
  APIRequest.address({
    this.method = HTTPMethods.get,
    required this.path,
    this.parameters,
    this.body,
    this.headers = const {'Token': '6e5793d8-2663-11ec-8b9b-3a2e6f5c2d91'},
  });
  HTTPMethod method;
  String path;
  dynamic parameters;
  dynamic body;
  dynamic headers;
}
