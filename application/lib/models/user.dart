class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.posts,
    required this.accessToken,
  });

  String id;
  String username;
  String email;
  bool isAdmin;
  List<String> posts;
  String accessToken;

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      posts: List<String>.from(map['posts']),
      accessToken: map['accessToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'isAdmin': isAdmin,
      'posts': posts,
      'accessToken': accessToken,
    };
  }
}
