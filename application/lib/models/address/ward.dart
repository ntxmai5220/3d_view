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
      'code': code,
      'districtId': districtId,
      'name': name,
    };
  }

  factory Ward.fromJson(Map<String, dynamic> map) {
    return Ward(
      code: map['WardCode'],
      districtId: map['DistrictID']?.toInt(),
      name: map['WardName'],
    );
  }
  factory Ward.fromApp(Map<String, dynamic> map) {
    return Ward(
      code: map['code'].toString(),
      districtId: map['districtId']?.toInt(),
      name: map['name'],
    );
  }
}
