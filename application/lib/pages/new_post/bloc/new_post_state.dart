part of 'new_post_bloc.dart';

@immutable
abstract class NewPostState {
  final Post? post;
  final int currentStep;
  const NewPostState({required this.currentStep, required this.post});
}

class NewPostInitial extends NewPostState {
  const NewPostInitial({
    required int currentStep,
    Post? post,
  }) : super(currentStep: currentStep, post: post);
}

class NewPostLoading extends NewPostState {
  const NewPostLoading({
    required int currentStep,
    Post? post,
  }) : super(currentStep: currentStep, post: post);
}

class NewPostError extends NewPostState {
  const NewPostError({
    required int currentStep,
    required Post? post,
  }) : super(currentStep: currentStep, post: post);
}

class NewPostDiscard extends NewPostState {
  const NewPostDiscard({
    required int currentStep,
    required Post? post,
  }) : super(currentStep: currentStep, post: post);
}
