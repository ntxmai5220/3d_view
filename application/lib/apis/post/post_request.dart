import 'package:bk_3d_view/apis/apis.dart';

class PostRequest {
  PostRequest._();
  // get post detail
  static APIRequest getPostDetail({required String id}) =>
      APIRequest.app(method: HTTPMethods.get, path: "post/$id");
}
