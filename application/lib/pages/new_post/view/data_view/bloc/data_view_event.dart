part of 'data_view_bloc.dart';

@immutable
abstract class DataViewEvent {}

class DataViewChangeAddressEvent<T> extends DataViewEvent {
  final T address;
  DataViewChangeAddressEvent({required this.address});
}

class DataViewInitEvent extends DataViewEvent {}

class DataViewLoadEvent<T> extends DataViewEvent {
  final int? id;
  DataViewLoadEvent({this.id});
}

class DataViewCheckDataEvent extends DataViewEvent {}
