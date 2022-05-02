import 'package:bk_3d_view/apis/apis.dart';
import 'package:flutter/services.dart';

class RemoveObjectRepository {
  final ApiExecute _apiExecute;
  RemoveObjectRepository({ApiExecute? apiExecute})
      : _apiExecute = apiExecute ?? ApiExecute(baseURL: BaseURLs.inpainting);

  Future inpainting({required ByteData image, required ByteData mask}) => RemoveObjectService(apiExecute: _apiExecute)
      .inpainting(image: image, mask: mask);
}
