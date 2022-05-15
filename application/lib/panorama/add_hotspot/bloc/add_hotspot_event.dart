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
