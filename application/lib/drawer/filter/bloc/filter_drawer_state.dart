part of 'filter_drawer_bloc.dart';

abstract class FilterDrawerState {
  FilterParam params;
  FilterDrawerState({
    required this.params,
  });
}

class FilterDrawerInitial extends FilterDrawerState {
  FilterDrawerInitial({required FilterParam params}) : super(params: params);
}
