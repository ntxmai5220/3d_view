class Province {
  Province({
    this.id,
    this.name,
  });
  int? id;
  String? name;

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
