import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/new_post/new_post_repository.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'data_view_event.dart';
part 'data_view_state.dart';

class DataViewBloc extends Bloc<DataViewEvent, DataViewState> {
  TextEditingController area = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController address = TextEditingController();
  final NewPostRepository _repository;
  DataViewBloc({required NewPostRepository repository})
      : _repository = repository,
        super(const DataViewInitial()) {
    on<DataViewInitEvent>(onInit);

    on<DataViewLoadEvent<Province>>(onLoadProvinces);
    on<DataViewLoadEvent<District>>(onLoadDistricts);
    on<DataViewLoadEvent<Ward>>(onLoadWards);

    on<DataViewChangeAddressEvent<Province>>(onChangeProvince);
    on<DataViewChangeAddressEvent<District>>(onChangeDistrict);
    on<DataViewChangeAddressEvent<Ward>>(onChangeWard);
  }

  onChangeProvince(
      DataViewChangeAddressEvent<Province> event, Emitter<DataViewState> emit) {
    var currentState = state;
    if (currentState is DataViewInitial) {
      emit(currentState.resetProvince(
          province: state.provinces?.indexOf(event.address) ?? 0));
      add(DataViewLoadEvent<District>(id: event.address.id ?? 0));
    }
  }

  onChangeDistrict(DataViewChangeAddressEvent<District> event,
      Emitter<DataViewState> emit) async {
    var currentState = state;
    if (currentState is DataViewInitial) {
      emit(currentState.resetDistrict(
          district: state.districts?.indexOf(event.address) ?? 0));
      add(DataViewLoadEvent<Ward>(id: event.address.id ?? 0));
    }
  }

  onChangeWard(DataViewChangeAddressEvent<Ward> event,
      Emitter<DataViewState> emit) async {
    var currentState = state;
    if (currentState is DataViewInitial) {
      emit(currentState.update(ward: state.wards?.indexOf(event.address) ?? 0));
      // add(DataViewLoadEvent<Ward>(id: event.district.id ?? 0));
    }
  }

  onInit(DataViewInitEvent event, Emitter<DataViewState> emit) async {
    add(DataViewLoadEvent<Province>());
  }

  onLoadProvinces(
      DataViewLoadEvent<Province> event, Emitter<DataViewState> emit) async {
    try {
      var result = await _repository.getProvince();
      emit(DataViewInitial(provinces: result.list));
      // return result.list;
    } catch (e) {
      emit(const DataViewInitial(provinces: []));
    }
  }

  onLoadDistricts(
      DataViewLoadEvent<District> event, Emitter<DataViewState> emit) async {
    try {
      var result = await _repository.getDistrict(
          provinceId: state.provinces?.elementAt(state.province ?? 0).id ?? 0);
      var currentState = state;
      if (currentState is DataViewInitial) {
        emit(currentState.update(districts: result.list));
        // emit(DataViewInitial(districts: result.list));
      }
      // return result.list;
    } catch (e) {}
  }

  onLoadWards(
      DataViewLoadEvent<Ward> event, Emitter<DataViewState> emit) async {
    try {
      var result = await _repository.getWard(
          districtId: state.districts?.elementAt(state.district ?? 0).id ?? 0);
      var currentState = state;
      if (currentState is DataViewInitial) {
        emit(currentState.update(wards: result.list));
        // emit(DataViewInitial(districts: result.list));
      } else {
        print('abc');
      }
      // return result.list;
    } catch (e) {}
  }
}
