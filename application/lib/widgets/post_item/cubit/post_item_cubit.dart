import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_item_state.dart';

class PostItemCubit extends Cubit<bool> {
  final PostRepository _repository;
  PostItemCubit({required PostRepository repository})
      : _repository = repository,
        super(false);

  initItem(bool isFavorite) => emit(isFavorite);

  toggleFavorite({required String postId}) async {
    var result =await _repository.follow(postId: postId, isFavorite: !state);
emit(!state);
  }
    }
