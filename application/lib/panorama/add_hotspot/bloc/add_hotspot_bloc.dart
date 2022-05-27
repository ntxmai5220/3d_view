
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:panorama/module.dart';



part 'add_hotspot_event.dart';
part 'add_hotspot_state.dart';

class AddHotspotBloc extends Bloc<AddHotspotEvent, AddHotspotState> {
  final AddHotspotRepository _repository;
  AddHotspotBloc({required AddHotspotRepository repository})
      : _repository = repository,
        super(AddHotspotInitial()) {
    on<AddHotspotChangeActionEvent>(changeAction);
    on<AddHotspotLoadEvent>(init);
    on<AddHotspotAddEvent>(addHotspot);
    on<AddHotspotDeleteEvent>(deleteHotspot);
    on<AddHotspotSaveEvent>(saveHotspot);
  }

  init(AddHotspotLoadEvent event, Emitter<AddHotspotState> emit) async {
    // _repository.addHotspot(roomId: event.roomId, hotspots: hotspots);
    emit(AddHotspotLoading(
        status: state.status, room: state.room, isChanged: state.isChanged));
    var result = await _repository.getRoom(id: event.roomId);
    emit(AddHotspotLoaded(
        status: state.status, room: result.object, isChanged: false));
  }

  changeAction(
      AddHotspotChangeActionEvent event, Emitter<AddHotspotState> emit) {
    if (state.status == event.type) {
      emit(AddHotspotLoaded(
          status: PanoramActionType.none,
          room: state.room,
          isChanged: state.isChanged));
    } else {
      emit(AddHotspotLoaded(
          status: event.type, room: state.room, isChanged: state.isChanged));
    }
  }

  addHotspot(AddHotspotAddEvent event, Emitter<AddHotspotState> emit) {
    HotspotModel h = HotspotModel(
        currentRoom: state.room?.id,
        nextRoom: event.nextRoom?.id,
        latitude: event.lat,
        longitude: event.long,
        title: event.title ?? event.nextRoom?.name,
        content: event.content,
        type: event.type.index);
    if (state.room?.hotspots == null) {
      state.room?.hotspots = [h];
    } else {
      state.room?.hotspots?.add(h);
    }
    // state.room?.hotspots = list;
    debugPrint(state.room?.hotspots?.length.toString());
    emit(AddHotspotLoaded(
        status: state.status, room: state.room, isChanged: true));
  }

  deleteHotspot(AddHotspotDeleteEvent event, Emitter<AddHotspotState> emit) {
    state.room?.hotspots?.remove(event.item);
    emit(AddHotspotLoaded(
        status: state.status, room: state.room, isChanged: true));
  }

  saveHotspot(AddHotspotSaveEvent event, Emitter<AddHotspotState> emit) async {
    var currentState = state;
    if (currentState.room?.hotspots != null &&
        currentState.room!.hotspots!.isNotEmpty) {
      emit(AddHotspotLoading(
          status: state.status, room: state.room, isChanged: state.isChanged));
      // await Future.delayed(const Duration(seconds: 1));
      await _repository.addHotspot(
        roomId: currentState.room?.id ?? '',
        hotspots: currentState.room?.hotspots
                ?.map((room) => room.toJson())
                .toList() ??
            [],
      );
      if (event.willLeave) {
        emit(AddHotspotLeave(status: state.status));
      } else {
        emit(AddHotspotSaved(status: state.status, room: state.room));
      }
    }
  }
}
