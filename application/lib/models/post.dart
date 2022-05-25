import 'package:bk_3d_view/models/models.dart';

class Post {
  Post({
    this.id,
    this.area,
    this.price,
    this.isUsed,
    this.isRent,
    this.isFavorite,
    this.isHidden,
    this.desc,
    this.address,
    this.province,
    this.district,
    this.ward,
    this.rooms,
    this.creatorId,
    this.createdAt,
  });

  String? id;
  double? area;
  double? price;
  bool? isUsed;
  bool? isRent;
  bool? isFavorite;
  bool? isHidden;
  String? desc;

  //address
  String? address;
  Province? province;
  District? district;
  Ward? ward;

  // List<String>? rooms;
  List<Room>? rooms;
  String? creatorId;
  DateTime? createdAt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['_id'],
        area: json['area']?.toDouble(),
        price: json['price']?.toDouble(),
        isUsed: json['isUsed'],
        isRent: json["isRent"],
        isFavorite: json['isFavorite'],
        isHidden: json['isHidden'],
        desc: json['desc'],
        address: json['address'],
        province: json['province'] != null
            ? Province.fromApp(json['province'])
            : null,
        district: json['province'] != null
            ? District.fromApp(json['district'])
            : null,
        ward: json['ward'] != null ? Ward.fromApp(json['ward']) : null,
        // rooms: json['rooms'] != null
        //     ? List<String>.from(json['rooms']).toList()
        //     : null,
        rooms: json['rooms'] != null
            ? List<Map<String, dynamic>>.from(json['rooms'])
                .map((e) => Room.fromJson(e))
                .toList()
            : null,
        creatorId: json['creatorId'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
      );

  Map<String, String> toFormData() => {
        // 'id': id ?? '',
        'area': area?.toString() ?? '',
        'price': price?.toString() ?? '',
        'isUsed': isUsed?.toString()??'false',
        'isRent': isRent?.toString() ?? 'false',
        'isFavorite':isFavorite?.toString() ?? 'false',
        'isHidden':isHidden?.toString() ?? 'false',
        'province[id]': province?.id.toString() ?? '',
        'province[name]': province?.name ?? '',
        'district[id]': district?.id.toString() ?? '',
        'district[name]': district?.name ?? '',
        'district[provinceId]': district?.provinceId.toString() ?? '',
        'ward[code]': ward?.code.toString() ?? '',
        'ward[name]': ward?.name ?? '',
        'ward[districtId]': ward?.districtId.toString() ?? '',
        'desc': desc ?? '',
        'address': address ?? '',
        // 'province': province?.toJson().toString() ?? '',
        // 'district': district?.toJson().toString() ?? '',
        // 'ward': ward?.toJson().toString() ?? '',
        // 'rooms': rooms,
        // 'creatorId': creatorId ?? '',
        // 'creationTime': creationTime?.toIso8601String() ?? '',
      };

      String getAddress(){
        return "$address, ${ward?.name}, ${district?.name}, ${province?.name}";
      }

      String getCreatedDate(){
        return createdAt.toString().split(" ").first;
      }

      String getPostStatus() => isRent! ? "Cho thuê" : "Bán" ;

}
