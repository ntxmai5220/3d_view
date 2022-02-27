class Room {
  Room({
    this.postId,
    this.name,
    this.id,
    this.img,
  });

  String? postId;
  String? name;
  int? id;
  String? img; //link anh

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        postId: json['postId'],
        name: json['name'],
        id: json['id']?.toInt(),
        img: json['img'],
      );

  Map<String, dynamic> toMap() => {
        'postId': postId,
        'name': name,
        'id': id,
        'img': img,
      };
}
