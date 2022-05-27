import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_object_event.dart';
part 'add_object_state.dart';

class AddObjectBloc extends Bloc<AddObjectEvent, AddObjectState> {
  AddObjectBloc() : super(AddObjectInitial(background: BackgroundType.origin)) {
    on<AddObjectChangeBackgroundEvent>(changeBackground);
  }

  changeBackground(
      AddObjectChangeBackgroundEvent event, Emitter<AddObjectState> emit) {
    if (state.background == BackgroundType.origin) {
      emit(AddObjectInitial(background: BackgroundType.removed));
    } else {
      emit(AddObjectInitial(background: BackgroundType.origin));
    }
  }
}
