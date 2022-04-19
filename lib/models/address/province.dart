import 'package:bk_3d_view/models/address/address.dart';

class Province extends Address {
  Province({
    this.id,
    String? name,
  }) : super(name: name);
  int? id;

  Map<String, dynamic> toJson() {
    return {
      'ProvinceID': id,
      'ProvinceName': name,
    };
  }

  factory Province.fromJson(Map<String, dynamic> map) {
    return Province(
      id: map['ProvinceID']?.toInt(),
      name: map['ProvinceName'],
    );
  }
}
