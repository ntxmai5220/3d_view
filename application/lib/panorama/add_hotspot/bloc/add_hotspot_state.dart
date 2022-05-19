part of 'add_hotspot_bloc.dart';

abstract class AddHotspotState {
  PanoramActionType status;
  Room? room;
  bool isChanged;
  AddHotspotState({
    required this.status,
    required this.isChanged,
    this.room,
  });
}

class AddHotspotInitial extends AddHotspotState {
  AddHotspotInitial({
    PanoramActionType status = PanoramActionType.none,
    Room? room,
  }) : super(status: status, room: room, isChanged: false);
}

class AddHotspotLoading extends AddHotspotState {
  AddHotspotLoading({
    required PanoramActionType status,
    required bool isChanged,
    Room? room,
  }) : super(status: status, room: room, isChanged: isChanged);
}

class AddHotspotLoaded extends AddHotspotState {
  AddHotspotLoaded({
    required PanoramActionType status,
    required bool isChanged,
    Room? room,
  }) : super(status: status, room: room, isChanged: isChanged);
}

class AddHotspotSaved extends AddHotspotState {
  AddHotspotSaved({
    required PanoramActionType status,
    Room? room,
  }) : super(status: status, room: room, isChanged: false);
}

class AddHotspotLeave extends AddHotspotState {
  AddHotspotLeave({
    required PanoramActionType status,
  }) : super(status: status, isChanged: false);
}
