// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      isAdmin: json['isAdmin'] as bool,
      posts: (json['posts'] as List<dynamic>).map((e) => e as String).toList(),
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'isAdmin': instance.isAdmin,
      'posts': instance.posts,
      'accessToken': instance.accessToken,
    };
