import 'package:bk_3d_view/apis/apis.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class RemoveObjectRequest {
  RemoveObjectRequest._();

  static APIRequest inpainting(
      {required ByteData image, required ByteData mask}) {
        // MultipartFile.
    FormData formData = FormData.fromMap({
      // 'image': MultipartFile.fromString(image.buffer.toString(), ),
      // 'mask': MultipartFile.fromString(mask.buffer.toString()),
      'image': MultipartFile.fromBytes(image.buffer.asInt64List().cast<int>(), filename:'image.png'),
      'mask': MultipartFile.fromBytes(mask.buffer.asInt64List().cast<int>(),
      filename: 'mask.png'),
      'model': 'places2',
    });
    return APIRequest(method: HTTPMethods.post, path: '', body: formData);
  }
}
