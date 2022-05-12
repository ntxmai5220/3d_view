part of 'remove_object_bloc.dart';

abstract class RemoveObjectState {
  ui.Image? background;
  RemoveObjectState({
    required this.background,
  });
}

class RemoveObjectInitial extends RemoveObjectState {
  RemoveObjectInitial({ui.Image? background}) : super(background: background);
}

class RemoveObjectLoading extends RemoveObjectState {
  RemoveObjectLoading({ui.Image? background}) : super(background: background);
}

class RemoveObjectLoaded extends RemoveObjectState {
  RemoveObjectLoaded({required ui.Image background})
      : super(background: background);
}

class RemoveObjectGenMask extends RemoveObjectState {
  ui.Image? image;
  ui.Image? mask;
  RemoveObjectGenMask({required ui.Image? background, required})
      : super(background: background);
}

class RemoveObjectReceivedMask extends RemoveObjectState {
  String mask;
  RemoveObjectReceivedMask({
    required ui.Image? background,
    required this.mask,
  }) : super(background: background);
}
