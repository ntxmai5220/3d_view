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
      'id': id,
      'name': name,
      'provinceId': provinceId,
    };
  }

  factory District.fromJson(Map<String, dynamic> map) {
    return District(
      id: map['id']?.toInt(),
      name: map['name'],
      provinceId: map['provinceId']?.toInt(),
    );
  }
}
