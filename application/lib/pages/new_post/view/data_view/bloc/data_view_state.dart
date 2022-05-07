part of 'data_view_bloc.dart';

abstract class DataViewState {
  final int? province;
  final int? district;
  final int? ward;

  final List<Province>? provinces;
  final List<District>? districts;
  final List<Ward>? wards;

  bool? isValid;

  DataViewState(
      {this.province,
      this.district,
      this.ward,
      this.provinces,
      this.districts,
      this.wards,
      required this.isValid});
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
  }) : super(
            province: province,
            district: district,
            ward: ward,
            provinces: provinces,
            districts: districts,
            wards: wards,
            isValid: isValid);

  DataViewInitial update({
    int? province,
    int? district,
    int? ward,
    List<District>? districts,
    List<Ward>? wards,
  }) =>
      DataViewInitial(
        province: province ?? this.province,
        district: district ?? this.district,
        ward: ward ?? this.ward,
        provinces: provinces,
        districts: districts ?? this.districts,
        wards: wards ?? this.wards,
      );

  DataViewInitial resetProvince({required int province}) => DataViewInitial(
        province: province,
        provinces: provinces,
      );

  DataViewInitial resetDistrict({required int district}) => DataViewInitial(
        province: province,
        provinces: provinces,
        district: district,
        districts: districts,
      );

  DataViewInitial valid({required bool valid}) => DataViewInitial(
        province: province,
        provinces: provinces,
        district: district,
        districts: districts,
        ward: ward,
        wards: wards,
        isValid: valid,
      );
}
