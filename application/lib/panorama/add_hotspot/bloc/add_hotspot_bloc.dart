import 'dart:async';

import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_hotspot_event.dart';
part 'add_hotspot_state.dart';

class AddHotspotBloc extends Bloc<AddHotspotEvent, AddHotspotState> {
  AddHotspotRepository _repository;
  AddHotspotBloc({required AddHotspotRepository repository})
      : _repository = repository,
        super(AddHotspotInitial()) {
    on<AddHotspotChangeActionEvent>(changeAction);
    on<AddHotspotLoadEvent>(init);
  }

  init(AddHotspotLoadEvent event, Emitter<AddHotspotState> emit) {
    // _repository.addHotspot(roomId: event.roomId, hotspots: hotspots);
  }

  changeAction(
      AddHotspotChangeActionEvent event, Emitter<AddHotspotState> emit) {
    if (state.status == event.type) {
      emit(AddHotspotLoaded(status: PanoramActionType.none));
    } else {
      emit(AddHotspotLoaded(status: event.type));
    }
  }
}
