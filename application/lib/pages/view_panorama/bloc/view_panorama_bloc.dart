import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_panorama_event.dart';
part 'view_panorama_state.dart';

class ViewPanoramaBloc extends Bloc<ViewPanoramaEvent, ViewPanoramaState> {
  final ViewPanoramaRepository _repository;
  ViewPanoramaBloc({required ViewPanoramaRepository repository})
      : _repository = repository,
        super(ViewPanoramaInitial(rooms: [], currentRoom: 0)) {
    on<ViewPanoramInitEvent>(init);
    on<ViewPanoramaChangeByIdEvent>(changeRoomById);
  }

  init(ViewPanoramInitEvent event, Emitter<ViewPanoramaState> emit) async {
    emit(
        ViewPanoramaLoaded(currentRoom: state.currentRoom, rooms: event.rooms));
    emit(ViewPanoramaLoading(
        currentRoom: state.currentRoom, rooms: state.rooms));

    try {
      // await Future.delayed(Duration(seconds: 2));
      var response =
          await _repository.getRoom(id: state.rooms.elementAt(0).id ?? '');
      state.rooms[0] = response.object;
      // add(ViewPanoramaChangeByIdEvent(id: state.rooms[0].id!));
      // emit(ViewPanoramaLoaded(
      //     currentRoom: state.currentRoom, rooms: event.rooms));
      for (int i = 1; i < state.rooms.length; i++) {
        getRoomDetail(index: i);
        //  var response =
        //     await _repository.getRoom(id: state.rooms[i].id ?? '');
        // // int index = state.rooms.indexWhere((element) => element.id == id);
        // state.rooms[i] = response.object;
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(ViewPanoramaLoaded(
          currentRoom: state.currentRoom, rooms: event.rooms));
    } catch (e) {
      emit(ViewPanoramaError(
          currentRoom: state.currentRoom, rooms: state.rooms));
    }
  }

  getRoomDetail({required int index}) async {
    var response = await _repository.getRoom(id: state.rooms[index].id ?? '');
    // int index = state.rooms.indexWhere((element) => element.id == id);
    state.rooms[index] = response.object;
  }

  changeRoomById(
      ViewPanoramaChangeByIdEvent event, Emitter<ViewPanoramaState> emit) {
    int index = state.rooms.indexWhere((element) => element.id == event.id);

    emit(ViewPanoramaLoaded(currentRoom: index, rooms: state.rooms));
  }
}
