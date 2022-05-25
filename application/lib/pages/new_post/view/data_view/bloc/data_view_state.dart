part of 'data_view_bloc.dart';

abstract class DataViewState {
  final int? province;
  final int? district;
  final int? ward;

  final List<Province>? provinces;
  final List<District>? districts;
  final List<Ward>? wards;

  bool? isValid;
  int type;

  DataViewState({
    this.province,
    this.district,
    this.ward,
    this.provinces,
    this.districts,
    this.wards,
    required this.isValid,
    required this.type,
  });
}

class DataViewInitial extends DataViewState {
  DataViewInitial({
    int? province,
    int? district,
    int? ward,
    List<Province>? provinces,
    List<District>? districts,
    List<Ward>? wards,
    bool? isValid,
    int type = 0,
  }) : super(
          province: province,
          district: district,
          ward: ward,
          provinces: provinces,
          districts: districts,
          wards: wards,
          isValid: isValid,
          type: type,
        );

  DataViewInitial update({
    int? province,
    int? district,
    int? ward,
    List<District>? districts,
    List<Ward>? wards,
    int? type,
  }) =>
      DataViewInitial(
        province: province ?? this.province,
        district: district ?? this.district,
        ward: ward ?? this.ward,
        provinces: provinces,
        districts: districts ?? this.districts,
        wards: wards ?? this.wards,
        type: type ?? this.type,
      );

  DataViewInitial resetProvince({required int province}) => DataViewInitial(
        province: province,
        provinces: provinces,
        type: type,
      );

  DataViewInitial resetDistrict({required int district}) => DataViewInitial(
        province: province,
        provinces: provinces,
        district: district,
        districts: districts,
        type: type,
      );

  DataViewInitial valid({required bool valid}) => DataViewInitial(
        province: province,
        provinces: provinces,
        district: district,
        districts: districts,
        ward: ward,
        wards: wards,
        isValid: valid,
        type: type,
      );
}
