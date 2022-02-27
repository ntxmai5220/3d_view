class Ward {
  Ward({
    this.code,
    this.districtId,
    this.name,
  });
  String? code;
  int? districtId;
  String? name;

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
