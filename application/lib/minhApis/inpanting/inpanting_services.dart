import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class InPaintingServices {
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2tleV9pZCI6NDgsImV4cCI6MTY1NjMyMzk1MywiaWF0IjoxNjUzNzMxOTUzfQ.b0rsFdRtNnocIJQrzW7i4JrsuviqX35BnMKW5c7azGQ";
  Future<ObjectResponse<String?>> removeWithMask(
      {required String base64Image, required String base64Mask}) async {
    DioRequest request = InPaintingRequest.removeWithMask(
        base64Image: base64Image, base64Mask: base64Mask, token: token);
    dynamic data = await InPantingClient.removeWithMask(
        data: request.body, options: request.options);
    // print(data["results"]["output"]);
    if (data != null && data['ok'] == true) {
      return ObjectResponse(object: data["results"]["output"]);
    } else {
      return ObjectResponse(object: null);
    }
  }
}
