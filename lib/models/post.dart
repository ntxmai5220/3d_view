import 'package:bk_3d_view/models/models.dart';

class Post {
  Post({
    this.id,
    this.area,
    this.price,
    this.isNew,
    this.isFavorite,
    this.isHidden,
    this.desc,
    this.address,
    this.province,
    this.district,
    this.ward,
    this.rooms,
    this.creatorId,
    this.creationTime,
  });

  String? id;
  double? area;
  double? price;
  bool? isNew;
  bool? isFavorite;
  bool? isHidden;
  String? desc;

  //address
  String? address;
  Province? province;
  District? district;
  Ward? ward;

  List<Room>? rooms;
  String? creatorId;
  DateTime? creationTime;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        area: json['area']?.toDouble(),
        price: json['price']?.toDouble(),
        isNew: json['isNew'],
        isFavorite: json['isFavorite'],
        isHidden: json['isHidden'],
        desc: json['desc'],
        address: json['address'],
        province: json['province'] != null
            ? Province.fromJson(json['province'])
            : null,
        district: json['province'] != null
            ? District.fromJson(json['district'])
            : null,
        ward: json['ward'] != null ? Ward.fromJson(json['ward']) : null,
        rooms: json['rooms'] != null
            ? List<Map<String, dynamic>>.from(json['rooms'])
                .map((e) => Room.fromJson(e))
                .toList()
            : null,
        creatorId: json['creatorId'],
        creationTime: json['creationTime'] != null
            ? DateTime.parse(json['creationTime']).toLocal()
            : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'area': area,
        'price': price,
        'isNew': isNew,
        'isFavorite':isFavorite,
        'isHidden':isHidden,
        'desc': desc,
        'address': address,
        'province': province,
        'district': district,
        'ward': ward,
        'rooms': rooms,
        'creatorId': creatorId,
        'creationTime': creationTime?.toIso8601String(),
      };
}