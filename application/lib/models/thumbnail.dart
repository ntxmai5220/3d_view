class Thumbnail {
  Thumbnail({
    this.thumbnailUrl,
    this.id,
  });

  final String? thumbnailUrl;
  // final String? publicId;
  final String? id;

  Map<String, dynamic> toMap() {
    return {
      'thumbnailUrl': thumbnailUrl,
      'id': id,
    };
  }

  factory Thumbnail.fromJson(Map<String, dynamic> map) {
    return Thumbnail(
      thumbnailUrl: map['thumbnailUrl'],
      id: map['_id'],
    );
  }
}
