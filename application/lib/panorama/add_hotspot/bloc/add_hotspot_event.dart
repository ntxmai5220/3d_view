part of 'add_hotspot_bloc.dart';

@immutable
abstract class AddHotspotEvent {}

class AddHotspotChangeActionEvent extends AddHotspotEvent {
  final PanoramActionType type;
  AddHotspotChangeActionEvent({
    required this.type,
  });
}

class AddHotspotLoadEvent extends AddHotspotEvent {
  final String roomId;
  AddHotspotLoadEvent({
    required this.roomId,
  });
}

class AddHotspotAddEvent extends AddHotspotEvent {
  final Room? nextRoom;
  final double long;
  final double lat;
  final HotspotType type;
  final String? title;
  final String? content;
  AddHotspotAddEvent({
    this.nextRoom,
    required this.long,
    required this.lat,
    required this.type,
    this.title,
    this.content,
  });
}

class AddHotspotDeleteEvent extends AddHotspotEvent {
  final HotspotModel item;
  AddHotspotDeleteEvent({
    required this.item,
  });
}
