import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'followed_event.dart';
part 'followed_state.dart';

class FollowedBloc extends Bloc<FollowedEvent, FollowedState> {
  RefreshController refreshController = RefreshController();
  // ScrollController scrollController = ScrollController();
  final FollowedRepository _repository;
  FollowedBloc({required FollowedRepository repository})
      : _repository = repository,
        super(FollowedInitial(post: [], params: FilterParam(limit: 8))) {
    on<FollowedLoadEvent>(loadData);
    on<FollowedLoadMoreEvent>(loadMore);
    on<FollowedRefreshEvent>(refresh);
  }

  loadData(FollowedLoadEvent event, Emitter<FollowedState> emit) async {
    // emit(FollowedLoading(post: state.post));
    // event.params.resetPage();
    if (state is FollowedLoaded) {
      emit(FollowedLoading(post: state.post, params: event.params));
    }
    var result =
        await _repository.getPostFilter(params: event.params.toFilterParam());
    // scrollController.jumpTo(0);
    emit(FollowedLoaded(post: result.list, params: event.params));
  }

  loadMore(FollowedLoadMoreEvent event, Emitter<FollowedState> emit) async {
    // emit(FollowedLoading(post: state.post));
    // FilterParam param = FilterParam(limit: 8);

    state.params.nextPage();
    var result =
        await _repository.getPostFilter(params: state.params.toFilterParam());
    if (result.list.isEmpty) {
      refreshController.loadNoData();
    }
    refreshController.loadComplete();
    emit(FollowedLoaded(
        post: state.post..addAll(result.list), params: state.params));
  }

  refresh(FollowedRefreshEvent event, Emitter<FollowedState> emit) async {
    state.params.resetPage();
    var result =
        await _repository.getPostFilter(params: state.params.toFilterParam());
    refreshController.refreshCompleted();
    emit(FollowedLoaded(post: result.list, params: state.params));
  }
}