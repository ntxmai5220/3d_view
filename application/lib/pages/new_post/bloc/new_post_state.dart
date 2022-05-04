part of 'new_post_bloc.dart';

@immutable
abstract class NewPostState {
  final String? postId;
  final int currentStep;
  const NewPostState({required this.currentStep, required this.postId});
}

class NewPostInitial extends NewPostState {
  const NewPostInitial({
    required int currentStep,
    String? postId,
  }) : super(currentStep: currentStep, postId: postId);
}

class NewPostLoading extends NewPostState {
  const NewPostLoading({
    required int currentStep,
    String? postId,
  }) : super(currentStep: currentStep, postId: postId);
}
