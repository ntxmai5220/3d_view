import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/followed/bloc/followed_bloc.dart';
import 'package:bk_3d_view/repositories/home/home_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;
  final FollowedBloc _followedBloc;
  final RefreshController controller = RefreshController();
  HomeBloc(
      {required HomeRepository repository, required FollowedBloc followedBloc})
      : _repository = repository,
        _followedBloc = followedBloc,
        super(HomeInitial()) {
    on<HomeLoadDataEvent>(loadData);
    on<HomeToggleFromOther>(toggleFromOther);
    on<HomeToggleFavoriteEvent>(toggleFavorite);
  }

  loadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading(
        banners: state.banners,
        newPost: state.newPost,
        hotPost: state.hotPost,
      ));
      var response1 = await _repository.getBanners();
      var banners = response1.list.reversed.toList();
      print(HelperSharedPreferences.savedlistFollow.toString());
      emit(HomeLoaded(
          banners: banners, newPost: state.newPost, hotPost: state.hotPost));
      controller.refreshCompleted();
      FilterParam param = FilterParam(
          limit: 8, creatorIdNEQ: HelperSharedPreferences.savedUserId);
      var response2 =
          await _repository.getPostFilter(params: param.toHomeParam());
      var newPost = response2.list;
      emit(HomeLoaded(
          banners: banners, newPost: newPost, hotPost: state.hotPost));
      var response3 = await _repository.getPostFilter(
          params: param.toHomeParam(sortByFavorite: true));
      var hotPost = response3.list;

      emit(HomeLoaded(
          banners: state.banners, newPost: state.newPost, hotPost: hotPost));
    } catch (e) {
      controller.refreshCompleted();
      emit(HomeLoadError(
        banners: state.banners,
        newPost: state.newPost,
        hotPost: state.hotPost,
      ));
    }
  }

  toggleFromOther(HomeToggleFromOther event, Emitter<HomeState> emit) {
    var id1 = state.hotPost.indexWhere((element) => element.id == event.postId);
    if (id1 != -1) {
      state.hotPost[id1].isFavorite = !event.isFavorite;
      emit(HomeLoaded(
          banners: state.banners,
          newPost: state.newPost,
          hotPost: state.hotPost));
    }
    var id2 = state.newPost.indexWhere((element) => element.id == event.postId);
    if (id2 != -1) {
      state.newPost[id2].isFavorite = !event.isFavorite;
      emit(HomeLoaded(
          banners: state.banners,
          newPost: state.newPost,
          hotPost: state.hotPost));
    }
  }

  toggleFavorite(HomeToggleFavoriteEvent event, Emitter<HomeState> emit) async {
    try {
      if (!event.isFavorite) {
        HelperSharedPreferences.savedlistFollow.add(event.postId);
      } else {
        HelperSharedPreferences.savedlistFollow.remove(event.postId);
      }
      var result = await _repository.follow(
          postId: event.postId, isFavorite: !event.isFavorite);
      _followedBloc.add(FollowedRefreshEvent());
      // state.post.removeWhere((element) => element.id == event.postId);
      var id1 =
          state.hotPost.indexWhere((element) => element.id == event.postId);
      if (id1 != -1) {
        state.hotPost[id1].isFavorite = !event.isFavorite;
      }
      var id2 =
          state.newPost.indexWhere((element) => element.id == event.postId);
      if (id2 != -1) {
        state.newPost[id2].isFavorite = !event.isFavorite;
      }

      emit(HomeLoaded(
          banners: state.banners,
          newPost: state.newPost,
          hotPost: state.hotPost));
    } catch (e) {
      print(e.toString());
    }
  }
}
