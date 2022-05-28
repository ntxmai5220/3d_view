class User {
  User({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.isAdmin,
    this.posts,
    this.accessToken,
    this.follows,
  });

  String? id;
  String? username;
  String? email;
  String? phone;
  bool? isAdmin;
  List<String>? posts;
  String? accessToken;
  List<String>? follows;

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map['_id'],
        username: map['username'],
        email: map['email'],
        phone: map['phone'],
        isAdmin: map['isAdmin'],
        posts: map['posts'] != null ? List<String>.from(map['posts']) : null,
        accessToken: map['accessToken'],
        follows:
            map['follows'] != null ? List<String>.from(map['follows']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'isAdmin': isAdmin,
      'posts': posts,
      'accessToken': accessToken,
      "follows": follows,
    };
  }
}
