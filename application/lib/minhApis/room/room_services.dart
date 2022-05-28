import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class RoomServices {
  Future<dynamic> updateRoom({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    DioRequest request = RoomRequest.updateRoom(
      id: id,
      body: body,
    );
    APIResponse data = await DioClient.put(
      path: request.path,
      options: request.options,
      data: request.body,
    );
    print(data.toObject());
  }

  Future<ObjectResponse<Room>> getRoom({
    required String id,
  }) async {
    DioRequest request = RoomRequest.getRoom(
      id: id,
    );
    APIResponse data = await DioClient.get(
      path: request.path,
      options: request.options,
    );

    Room room = Room.fromJson(data.toObject());
    return ObjectResponse(object: room);
  }

  Future<dynamic> deleteRoom({
    required String id,
  }) async {
    DioRequest request = RoomRequest.deleteRoom(
      id: id,
    );
    await DioClient.delete(
      path: request.path,
      options: request.options,
    );
  }
}
