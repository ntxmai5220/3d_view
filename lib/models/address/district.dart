import 'package:bk_3d_view/models/address/address.dart';

class District extends Address {
  District({
    this.id,
    String? name,
    this.provinceId,
  }) : super(name: name);

  int? id;
  int? provinceId;

  Map<String, dynamic> toJson() {
    return {
      'DistrictID': id,
      'DistrictName': name,
      'ProvinceID': provinceId,
    };
  }

  factory District.fromJson(Map<String, dynamic> map) {
    return District(
      id: map['DistrictID']?.toInt(),
      name: map['DistrictName'],
      provinceId: map['ProvinceID']?.toInt(),
    );
  }
}
