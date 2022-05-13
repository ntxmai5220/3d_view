import 'dart:typed_data';

import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class RemoveObjectRepository {
  RemoveObjectRepository();
  final PostServices postServices = PostServices();
  final InPaintingServices inPaintingServies = InPaintingServices();

  Future<ObjectResponse<String?>> sendMask(
          {required String base64Image, required String base64Mask}) =>
      inPaintingServies.removeWithMask(
          base64Image: base64Image, base64Mask: base64Mask);

  Future<ObjectResponse<Room?>> uploadRemoveImage({
    required String roomId,
    required MapEntry<String,Uint8List> removeImage,
  }) =>
      postServices.uploadRemoveImage(roomId: roomId, removeImage: removeImage);
}
