part of 'remove_object_bloc.dart';

@immutable
abstract class RemoveObjectEvent {}

class RemoveObjectSendMaskEvent extends RemoveObjectEvent {
  final ByteData image;
  final ByteData mask;
  RemoveObjectSendMaskEvent({
    required this.image,
    required this.mask,
  });
}

class RemoveObjectInitEvent extends RemoveObjectEvent {
  final String url;
  RemoveObjectInitEvent({
    required this.url,
  });
}

class ToggleDrawEvent extends RemoveObjectEvent {}

class ToggleEraseEvent extends RemoveObjectEvent {}

class UndoEvent extends RemoveObjectEvent {}

class RedoEvent extends RemoveObjectEvent {}

class RemoveObjectGenMaskEvent extends RemoveObjectEvent{}
