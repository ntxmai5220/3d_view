import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  RefreshController refreshController = RefreshController();
  // ScrollController scrollController = ScrollController();
  final SearchRepository _repository;
  SearchBloc({required SearchRepository repository})
      : _repository = repository,
        super(SearchInitial(post: [], params: FilterParam(limit: 6, creatorIdNEQ: HelperSharedPreferences.savedUserId))) {
    on<SearchLoadEvent>(loadData);
    on<SearchLoadMoreEvent>(loadMore);
    on<SearchRefreshEvent>(refresh);
    on<SearchToggleFavoriteEvent>(toggleFavorite);
  }

  loadData(SearchLoadEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoading(post: state.post));
    event.params.resetPage();
    if (state is SearchLoaded) {
      emit(SearchLoading(post: state.post, params: event.params));
    }
    try {
      var result =
          await _repository.getPostFilter(params: event.params.toFilterParam());
      // scrollController.jumpTo(0);
      refreshController.refreshCompleted();
      emit(SearchLoaded(post: result.list, params: event.params));
    } catch (e) {
      refreshController.refreshCompleted();
      emit(SearchError(params: state.params));
    }
  }

  loadMore(SearchLoadMoreEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoading(post: state.post));
    // FilterParam param = FilterParam(limit: 8);

    state.params.nextPage();
    var result =
        await _repository.getPostFilter(params: state.params.toFilterParam());
    if (result.list.isEmpty) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
      emit(SearchLoaded(
          post: state.post..addAll(result.list), params: state.params));
    }
  }

  refresh(SearchRefreshEvent event, Emitter<SearchState> emit) async {
    state.params.resetPage();
    var result =
        await _repository.getPostFilter(params: state.params.toFilterParam());
    refreshController.refreshCompleted();
    emit(SearchLoaded(post: result.list, params: state.params));
  }

  toggleFavorite(
      SearchToggleFavoriteEvent event, Emitter<SearchState> emit) async {
    try {
      if (!event.isFavorite) {
        HelperSharedPreferences.savedlistFollow.add(event.postId);
      } else {
        HelperSharedPreferences.savedlistFollow.remove(event.postId);
      }

      state.post
          .where((element) => element.id == event.postId)
          .first
          .isFavorite = !event.isFavorite;
      emit(SearchLoaded(post: state.post, params: state.params));
      var result = await _repository.follow(
          postId: event.postId, isFavorite: !event.isFavorite);

      // state.post.removeWhere((element) => element.id == event.postId);

    } catch (e) {}
  }
}
