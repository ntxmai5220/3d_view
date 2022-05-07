import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';

@JsonSerializable()
class User{
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.posts,
    required this.accessToken
  });
  @JsonKey(name: '_id')
  String id;
  String username;
  String email;
  bool isAdmin;
  List<String> posts;
  String accessToken;

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserToJson(this);


}