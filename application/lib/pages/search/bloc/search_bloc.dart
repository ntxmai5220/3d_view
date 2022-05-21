import 'dart:async';

import 'package:bk_3d_view/models/filter_param/filter_param.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  RefreshController refreshController = RefreshController();
  SearchRepository _repository;
  SearchBloc({required SearchRepository repository})
      : _repository = repository,
        super(SearchInitial(post: [], params: FilterParam(limit: 8))) {
    on<SearchLoadEvent>(loadData);
    on<SearchLoadMoreEvent>(loadMore);
    on<SearchRefreshEvent>(refresh);
  }

  loadData(SearchLoadEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoading(post: state.post));

    if (state is SearchLoaded) {
      emit(SearchLoading(post: state.post, params: event.params));
    }
    var result =
        await _repository.getPostFilter(params: event.params.toFilterParam());

    emit(SearchLoaded(post: result.list, params: event.params));
  }

  loadMore(SearchLoadMoreEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoading(post: state.post));
    // FilterParam param = FilterParam(limit: 8);

    state.params.nextPage();
    var result =
        await _repository.getPostFilter(params: state.params.toFilterParam());
    if (result.list.isEmpty) {
      refreshController.loadNoData();
    }
    refreshController.loadComplete();
    emit(SearchLoaded(
        post: state.post..addAll(result.list), params: state.params));
  }

  refresh(SearchRefreshEvent event, Emitter<SearchState> emit) async {
    state.params.resetPage();
    var result =
        await _repository.getPostFilter(params: state.params.toFilterParam());
    refreshController.refreshCompleted();
    emit(SearchLoaded(post: result.list, params: state.params));
  }
}
