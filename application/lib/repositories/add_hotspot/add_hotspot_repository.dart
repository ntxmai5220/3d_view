import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class AddHotspotRepository {
  AddHotspotRepository();

  final PostServices postServices = PostServices();
  final RoomServices roomServices = RoomServices();

  Future<ObjectResponse<Room>> addHotspot({
    required String roomId,
    required List<Map<String, dynamic>> hotspots,
  }) =>
      postServices.addHotspot(roomId: roomId, hotspots: hotspots);

  Future<ObjectResponse<Room>> getRoom({required String id}) =>
      roomServices.getRoom(id: id);
}
