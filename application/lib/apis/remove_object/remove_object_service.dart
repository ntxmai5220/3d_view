import 'package:bk_3d_view/apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RemoveObjectService {
  final ApiExecute apiExecute;

  RemoveObjectService({required this.apiExecute});

  Future inpainting({required ByteData image, required ByteData mask}) async {
    APIRequest request =
        RemoveObjectRequest.inpainting(image: image, mask: mask);
    APIResponse response = await apiExecute.remove(request: request);
    debugPrint(response.toString());
  }
}
