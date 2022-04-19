import 'package:bk_3d_view/models/address/address.dart';

class Ward extends Address {
  Ward({
    this.code,
    this.districtId,
    String? name,
  }) : super(name: name);
  String? code;
  int? districtId;

  Map<String, dynamic> toJson() {
    return {
      'WardCode': code,
      'DistrictID': districtId,
      'WardName': name,
    };
  }

  factory Ward.fromJson(Map<String, dynamic> map) {
    return Ward(
      code: map['WardCode'],
      districtId: map['DistrictID']?.toInt(),
      name: map['WardName'],
    );
  }
}
