import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final MyProfileRepository _repository;
  MyProfileBloc({required MyProfileRepository repository})
      : _repository = repository,
        super(MyProfileInitial(user: null)) {
    on<MyProfileInitEvent>(loadData);
  }

  loadData(MyProfileInitEvent event, Emitter<MyProfileState> emit) {}
}
