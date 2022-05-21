import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'main_page_event.dart';

class MainPageBloc extends Bloc<MainPageEvent, int> {
  TabController tabController;
  MainPageBloc({required TabController controller})
      : tabController = controller,
        super(0) {
    on<OnChangePage>((event, emit) {
      tabController.animateTo(event.index);
      emit(event.index);
    });
  }
}
