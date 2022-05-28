import 'dart:async';

import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/models.dart';

import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'manage_post_event.dart';
part 'manage_post_state.dart';

class ManagePostBloc extends Bloc<ManagePostEvent, ManagePostState> {
  RefreshController refreshController = RefreshController();
  // ScrollController scrollController = ScrollController();
  final ManagePostRepository _repository;
  ManagePostBloc({required ManagePostRepository repository})
      : _repository = repository,
        super(ManagePostInitial(
            post: [],
            params: FilterParam(
              limit: 8,
              creatorIdEQ: HelperSharedPreferences.savedUserId,
            ))) {
    on<ManagePostLoadEvent>(loadData);
    on<ManagePostLoadMoreEvent>(loadMore);
    on<ManagePostRefreshEvent>(refresh);
    on<ManagePostChangeTabEvent>(onChangeTab);
    on<ManagePostDeleteEvent>(onDeletePost);
  }

  loadData(ManagePostLoadEvent event, Emitter<ManagePostState> emit) async {
    // emit(ManagePostLoading(post: state.post));
    event.params.resetPage();
    if (state is ManagePostLoaded) {
      emit(ManagePostInitial(post: state.post, params: event.params));
    }
    var result =
        await _repository.getPostFilter(params: event.params.toUserParam());
    // scrollController.jumpTo(0);
    refreshController.refreshCompleted();
    emit(ManagePostLoaded(post: result.list, params: event.params));
  }

  loadMore(ManagePostLoadMoreEvent event, Emitter<ManagePostState> emit) async {
    // emit(ManagePostLoading(post: state.post));
    // FilterParam param = FilterParam(limit: 8);

    state.params.nextPage();
    var result =
        await _repository.getPostFilter(params: state.params.toUserParam());
    if (result.list.isEmpty) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
      emit(ManagePostLoaded(
          post: state.post..addAll(result.list), params: state.params));
    }
  }

  refresh(ManagePostRefreshEvent event, Emitter<ManagePostState> emit) async {
    state.params.resetPage();
    var result =
        await _repository.getPostFilter(params: state.params.toUserParam());
    refreshController.refreshCompleted();
    emit(ManagePostLoaded(post: result.list, params: state.params));
  }

  onChangeTab(ManagePostChangeTabEvent event, Emitter<ManagePostState> emit) {
    switch (event.index) {
      case 0:
        state.params.isHiddenEQ = null;
        break;
      case 1:
        state.params.isHiddenEQ = false;
        break;
      case 2:
        state.params.isHiddenEQ = true;
        break;
    }
    add(ManagePostLoadEvent(params: state.params));
  }

  onDeletePost(
      ManagePostDeleteEvent event, Emitter<ManagePostState> emit) async {
    try {
      emit(ManagePostLoading(post: state.post, params: state.params));
      var result = await _repository.deletePost(postId: event.postId);

      emit(ManagePostLoaded(
          post: state.post
            ..removeWhere((element) => element.id == event.postId),
          params: state.params));
    } catch (e) {
      emit(ManagePostError(post: state.post, params: state.params));
    }
  }
}
