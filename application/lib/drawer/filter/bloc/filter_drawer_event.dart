part of 'filter_drawer_bloc.dart';

@immutable
abstract class FilterDrawerEvent {}

class FilterChangeTypeEvent extends FilterDrawerEvent {
  final PostType type;
  FilterChangeTypeEvent({
    required this.type,
  });
}

class FilterSaveEvent extends FilterDrawerEvent {}

class FilterInitEvent extends FilterDrawerEvent {
  final FilterParam params;
  FilterInitEvent({
    required this.params,
  });
}
