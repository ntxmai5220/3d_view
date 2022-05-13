import 'package:bk_3d_view/models/models.dart';

class Room {
  Room({
    this.postId,
    this.name,
    this.id,
    this.imgUrl,
    this.removedImg,
    this.thumbnails,
    this.hotspots,
  });

  String? postId;
  String? name;
  String? id;
  String? imgUrl; //link anh
  Img? removedImg;
  // List<String>? thumbnails;
  List<Img>? thumbnails;
  List<Hotspot>? hotspots;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        postId: json['postId'],
        name: json['name'],
        id: json['_id'],
        imgUrl: json['imgUrl'],
        removedImg: json['removedImg'] != null
            ? Img.fromJson(json['removedImg'])
            : null,
        // thumbnails: json['thumbnail'] != null
        //     ? List<String>.from(json['thumbnail']).toList()
        //     : null,
        thumbnails: json['thumbnail'] != null
            ? List<Map<String, dynamic>>.from(json['thumbnail'])
                .map((e) => Img.fromJson(e))
                .toList()
            : null,
        hotspots: json['hotspot'] != null
            ? List<Map<String, dynamic>>.from(json['hotspot'])
                .map((e) => Hotspot.fromJson(e))
                .toList()
            : null,
      );

  Map<String, dynamic> toMap() => {
        'postId': postId,
        'name': name,
        'id': id,
        'imgUrl': imgUrl,
        'removeImgUrl': removedImg,
        'thumbnail': thumbnails,
        'hotspots': hotspots,
      };
}
