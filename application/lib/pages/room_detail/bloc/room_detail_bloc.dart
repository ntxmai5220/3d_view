import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'room_detail_event.dart';
part 'room_detail_state.dart';

class RoomDetailBloc extends Bloc<RoomDetailEvent, RoomDetailState> {
  final RoomDetailRepository _repository;
  RoomDetailBloc({required RoomDetailRepository repository})
      : _repository = repository,
        super(RoomDetailInitial()) {
    on<RoomDetailInitEvent>(init);
  }

  init(RoomDetailInitEvent event, Emitter<RoomDetailState> emit) async {
    try {
      emit(RoomDetailLoading());
      var response = await _repository.getRoom(id: event.roomId);
      emit(RoomDetailLoaded(room: response.object));
    } catch (e) {
      emit(RoomDetailError());
    }
  }
}
