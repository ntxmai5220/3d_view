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
