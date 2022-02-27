import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc() : super(PostDetailInitial()) {
    on<PostDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
