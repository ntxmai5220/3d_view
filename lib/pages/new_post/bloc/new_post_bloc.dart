import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  NewPostBloc() : super(NewPostInitial()) {
    on<NewPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
