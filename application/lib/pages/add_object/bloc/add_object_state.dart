part of 'add_object_bloc.dart';


abstract class AddObjectState {
  BackgroundType background;
  AddObjectState({
    required this.background,
  });
}

class AddObjectInitial extends AddObjectState {
  AddObjectInitial({required BackgroundType background}) : super(background: background);
}
