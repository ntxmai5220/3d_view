part of 'view_panorama_bloc.dart';

@immutable
abstract class ViewPanoramaEvent {}

class ViewPanoramaChangeByIdEvent extends ViewPanoramaEvent {
  final String id;
  ViewPanoramaChangeByIdEvent({
    required this.id,
  });
}

class ViewPanoramaLoadHotspotEvent extends ViewPanoramaEvent {
  final String id;
  ViewPanoramaLoadHotspotEvent({
    required this.id,
  });
}

class ViewPanoramInitEvent extends ViewPanoramaEvent {
  final List<Room> rooms;
  ViewPanoramInitEvent({
    required this.rooms,
  });

}
