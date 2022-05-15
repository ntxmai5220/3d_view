class Banner {
  Banner({
    this.title,
    this.content,
    this.webUrl,
    this.imgUrl,
  });

  String? title;
  String? content;
  String? webUrl;
  String? imgUrl;
  factory Banner.fromJson(Map<String, dynamic> map) {
    return Banner(
      imgUrl: map['imgUrl'],
      title: map['title'],
      content: map['content'],
      webUrl: map['webUrl'],
    );
  }
}
