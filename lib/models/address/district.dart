class District {
  District({
    this.id,
    this.name,
    this.provinceId,
  });

  int? id;
  String? name;
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
