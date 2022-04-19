import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  TextEditingController area = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController address = TextEditingController();
  final NewPostRepository _repository;
  NewPostBloc({required NewPostRepository repository})
      : _repository = repository,
        super(const NewPostInitial(currentStep: 0)) {
    on<NewPostNextEvent>(onNextStep);
    on<NewPostBackEvent>(onPreviousStep);
    on<NewPostDoneEvent>(onConmpleteStep);
  }

  onNextStep(NewPostNextEvent event, Emitter<NewPostState> emit) {
    int next = state.currentStep + 1;
    debugPrint('next');
    emit(NewPostInitial(currentStep: next));
  }

  onPreviousStep(NewPostBackEvent event, Emitter<NewPostState> emit) {
    int prev = state.currentStep - 1;
    debugPrint('back');
    emit(NewPostInitial(currentStep: prev));
  }

  onConmpleteStep(NewPostDoneEvent event, Emitter<NewPostState> emit) {
    debugPrint('done');
  }
}
