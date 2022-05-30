import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_user_event.dart';
part 'list_user_state.dart';

class ListUserBloc extends Bloc<ListUserEvent, ListUserState> {
  final ListUserRepository _repository;

  ListUserBloc({required ListUserRepository repository})
      : _repository = repository,
        super(ListUserInitial()) {
    on<ListUserInitEvent>(initData);
  }

  initData(ListUserInitEvent event, Emitter<ListUserState> emit) async {
    try {
      var result = await _repository.getAllUser();

      List<User> list = result.list;

      emit(ListUserLoaded(list: list));
    } catch (e) {
      emit(ListUserError());
    }
  }
}
