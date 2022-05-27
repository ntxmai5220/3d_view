import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/home/home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;
  final RefreshController controller = RefreshController();
  HomeBloc({required HomeRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    on<HomeLoadDataEvent>(loadData);
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
      emit(HomeLoaded(
          banners: banners, newPost: state.newPost, hotPost: state.hotPost));
      controller.refreshCompleted();
      FilterParam param = FilterParam(limit: 8);
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
      emit(HomeLoadError(
        banners: state.banners,
        newPost: state.newPost,
        hotPost: state.hotPost,
      ));
    }
  }
}
