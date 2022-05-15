part of 'add_hotspot_bloc.dart';

abstract class AddHotspotState {
  PanoramActionType status;
  AddHotspotState({
    required this.status,
  });
}

class AddHotspotInitial extends AddHotspotState {
  AddHotspotInitial({PanoramActionType status = PanoramActionType.none})
      : super(status: status);
}

class AddHotspotLoading extends AddHotspotState {
  AddHotspotLoading({required PanoramActionType status})
      : super(status: status);
}

class AddHotspotLoaded extends AddHotspotState {
  AddHotspotLoaded({required PanoramActionType status}) : super(status: status);
}
