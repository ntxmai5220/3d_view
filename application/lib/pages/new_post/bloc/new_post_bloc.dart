import 'dart:io';
import 'dart:typed_data';

import 'package:bk_3d_view/repositories/new_post/new_post_repository.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';

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
    on<NewPostJumpToEvent>(onJumpToStep);
    on<NewPostCreateEvent>(onCreatePost);
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

  onJumpToStep(NewPostJumpToEvent event, Emitter<NewPostState> emit) {
    emit(NewPostInitial(currentStep: event.index));
  }

  onCreatePost(NewPostCreateEvent event, Emitter<NewPostState> emit) async {
    debugPrint('create');
    List<MapEntry<String, Uint8List>> images = [];
    for (Room room in event.rooms) {
      Uint8List data = await File(room.imgUrl ?? '').readAsBytes();
      images
          .add(MapEntry('${room.name}.${room.imgUrl?.split(".").last}', data));
    }
    emit(NewPostLoading(currentStep: state.currentStep, postId: state.postId));
    var response = await _repository.createPost(
      userId: '625bd0648e18145a85211945',
      images: images,
      imageDescription: event.rooms.map((room) => room.name ?? '').toList(),
      landInfo: event.post.toFormData(),
    );
    debugPrint(response.object.id);
    response.object.rooms?.forEach(debugPrint);
    emit(NewPostInitial(
        currentStep: state.currentStep, postId: response.object.id));

    // await Future.delayed(const Duration(seconds: 5));
    add(NewPostNextEvent());
  }
}
