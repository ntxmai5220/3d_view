import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/filter_param/filter_param.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'filter_drawer_event.dart';
part 'filter_drawer_state.dart';

class FilterDrawerBloc extends Bloc<FilterDrawerEvent, FilterDrawerState> {
  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  TextEditingController area1 = TextEditingController();
  TextEditingController area2 = TextEditingController();
  FilterDrawerBloc()
      : super(FilterDrawerInitial(
            params: FilterParam(
                creatorIdNEQ: HelperSharedPreferences.savedUserId))) {
    on<FilterInitEvent>(init);
    on<FilterChangeTypeEvent>(onChangeType);
    on<FilterSaveEvent>(onSave);
  }

  onChangeType(FilterChangeTypeEvent event, Emitter<FilterDrawerState> emit) {
    state.params.isRentEQ = event.type.isRent;

    emit(FilterDrawerInitial(params: state.params));
  }

  onSave(FilterSaveEvent event, Emitter<FilterDrawerState> emit) {
    state.params.areaGTE = double.tryParse(area1.text);
    state.params.areaLTE = double.tryParse(area2.text);
    state.params.priceGTE = double.tryParse(price1.text);
    state.params.priceLTE = double.tryParse(price2.text);
  }

  init(FilterInitEvent event, Emitter<FilterDrawerState> emit) {
    price1.text = state.params.priceGTE?.toStringAsFixed(0) ?? '';
    price2.text = state.params.priceLTE?.toStringAsFixed(0) ?? '';
    area1.text = state.params.areaGTE?.toStringAsFixed(0) ?? '';
    area2.text = state.params.areaLTE?.toStringAsFixed(0) ?? '';
    emit(FilterDrawerInitial(params: event.params));
  }
}
