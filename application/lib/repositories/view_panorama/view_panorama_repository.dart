import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class ViewPanoramaRepository {
  RoomServices roomServices = RoomServices();

  Future<ObjectResponse<Room>> getRoom({required String id}) =>
      roomServices.getRoom(id: id);
}
