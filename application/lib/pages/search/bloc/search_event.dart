part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchRefreshEvent extends SearchEvent {}

class SearchLoadEvent extends SearchEvent {
  final FilterParam params;
  SearchLoadEvent({
    required this.params,
  });
}

class SearchLoadMoreEvent extends SearchEvent {}
