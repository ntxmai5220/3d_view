import 'dart:convert';

import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:dio/dio.dart';

class InPaintingRequest {
  InPaintingRequest._();

  static DioRequest removeWithMask({required String base64Image, required String base64Mask, required String token }){
    Options options = OptionBuilder().jsonContent().headers("authorizationToken",token).build();
    final body = {
      "image_b64": base64Image,
      "mask_b64": base64Mask
    };
    return DioRequest(path: "", options: options,  body: jsonEncode(body));
  }
}