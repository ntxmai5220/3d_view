part of 'new_post_bloc.dart';

@immutable
abstract class NewPostState {
  final int currentStep;
  const NewPostState({required this.currentStep});
}

class NewPostInitial extends NewPostState {
  const NewPostInitial({
    required int currentStep,
  }) : super(currentStep: currentStep);
}
