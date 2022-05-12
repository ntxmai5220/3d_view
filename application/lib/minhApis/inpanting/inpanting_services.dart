import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class InPaintingServices {
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2tleV9pZCI6NDcsImV4cCI6MTY1NDEwMTQwMywiaWF0IjoxNjUxNTA5NDAzfQ.AXP-Mkdf4qhuV78uah0MllfWBk4WnmejdOHZ_NyyH2M";
  Future<ObjectResponse<String?>> removeWithMask(
      {required String base64Image, required String base64Mask}) async {
    DioRequest request = InPaintingRequest.removeWithMask(
        base64Image: base64Image, base64Mask: base64Mask, token: token);
    dynamic data = await InPantingClient.removeWithMask(
        data: request.body, options: request.options);
    print(data["results"]["output"]);
    if (data != null) {
      return ObjectResponse(object: data["results"]["output"]);
    } else {
      return ObjectResponse(object: null);
    }
  }
}
