import 'package:bk_3d_view/minhApis/apis.dart';

class RoomServices{
  Future<dynamic> updateRoom({required String id, required String token, required Map<String, dynamic> body }) async {
    DioRequest request = RoomRequest.updateRoom(id: id, token: token, body: body);
    APIResponse data = await DioClient.put(
        path: request.path, options: request.options, data: request.body);
    print(data.toObject());
  }

  Future<dynamic> getRoom({required String id, required String token}) async {
    DioRequest request = RoomRequest.getRoom(id: id, token: token);
    dynamic data = await DioClient.get(
        path: request.path, options: request.options);
    print(data);
  }

  Future<dynamic> deleteRoom({required String id, required String token}) async {
    DioRequest request = RoomRequest.deleteRoom(id: id, token: token);
    await DioClient.delete(
        path: request.path, options: request.options);
  }
}