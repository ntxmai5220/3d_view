part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class OnChangePage extends MainPageEvent {
  final int index;

  OnChangePage(this.index);

}
