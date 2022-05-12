import 'package:bk_3d_view/apis/apis.dart';
import 'package:bk_3d_view/minhApis/apis.dart';

class InPaintingServies {
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2tleV9pZCI6NDcsImV4cCI6MTY1NDEwMTQwMywiaWF0IjoxNjUxNTA5NDAzfQ.AXP-Mkdf4qhuV78uah0MllfWBk4WnmejdOHZ_NyyH2M";
  Future<dynamic> removeWithMask({required String base64Image, required String base64Mask }) async {
    DioRequest request = InPaintingRequest.removeWithMask(base64Image: base64Image, base64Mask: base64Mask, token: token );
    dynamic data = await InPantingClient.removeWithMask(data: request.body, options: request.options);
    print(data["results"]["output"]);
  }
}