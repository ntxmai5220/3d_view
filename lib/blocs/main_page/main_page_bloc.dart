import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_page_event.dart';

class MainPageBloc extends Bloc<MainPageEvent, int> {
  MainPageBloc() : super(0) {
     on<OnChangePage>((event, emit) async {
      emit(event.index);
    });
  }
}
