import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'thumbnail_view_event.dart';
part 'thumbnail_view_state.dart';

class ThumbnailViewBloc extends Bloc<ThumbnailViewEvent, ThumbnailViewState> {
  ThumbnailViewBloc() : super(ThumbnailViewInitial()) {
    on<ThumbnailViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
