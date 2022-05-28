import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostDetailRepository _repository;
  PostDetailBloc({required PostDetailRepository repository})
      : _repository = repository,
        super(PostDetailInitial()) {
    on<PostDetailLoadEvent>(loadData);
  }
  loadData(PostDetailLoadEvent event, Emitter<PostDetailState> emit) async {
    try {
      emit(PostDetailLoading());
      var reponse = await _repository.getPostDetail(id: event.id);
      emit(PostDetailLoaded(post: reponse.object));
      var currentState = state;
      if (currentState is PostDetailLoaded) {
        var user = await _repository.getUserById(
            id: currentState.post.creatorId);
        emit(PostDetailLoaded(post: currentState.post, user: user.object));
      }
    } catch (e) {
      emit(PostDetailError());
    }
  }
}
