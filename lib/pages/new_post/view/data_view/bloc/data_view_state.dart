part of 'data_view_bloc.dart';

@immutable
abstract class DataViewState {
  final int? province;
  final int? district;
  final int? ward;

  final List<Province>? provinces;
  final List<District>? districts;
  final List<Ward>? wards;

  const DataViewState(
      {this.province,
      this.district,
      this.ward,
      this.provinces,
      this.districts,
      this.wards});
}

class DataViewInitial extends DataViewState {
  const DataViewInitial({
    int? province,
    int? district,
    int? ward,
    List<Province>? provinces,
    List<District>? districts,
    List<Ward>? wards,
  }) : super(
            province: province,
            district: district,
            ward: ward,
            provinces: provinces,
            districts: districts,
            wards: wards);

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
}

