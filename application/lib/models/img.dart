class Img {
  Img({
    this.imgUrl,
    this.id,
    this.publicId,
  });

  final String? imgUrl;
  final String? publicId;
  final String? id;

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'id': id,
      'publicId':publicId,
    };
  }

  factory Img.fromJson(Map<String, dynamic> map) {
    return Img(
      imgUrl: map['imgUrl'],
      publicId: map['publicId'],
      id: map['_id'],
    );
  }
}
