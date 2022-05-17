part of 'add_hotspot_bloc.dart';

abstract class AddHotspotState {
  PanoramActionType status;
  Room? room;
  AddHotspotState({
    required this.status,
    this.room,
  });
}

class AddHotspotInitial extends AddHotspotState {
  AddHotspotInitial({
    PanoramActionType status = PanoramActionType.none,
    Room? room,
  }) : super(status: status, room: room);
}

class AddHotspotLoading extends AddHotspotState {
  AddHotspotLoading({
    required PanoramActionType status,
    Room? room,
  }) : super(status: status, room: room);
}

class AddHotspotLoaded extends AddHotspotState {
  AddHotspotLoaded({
    required PanoramActionType status,
    Room? room,
  }) : super(status: status, room: room);
}
