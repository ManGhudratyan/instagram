// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followings: (json['followings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bio: json['bio'] as String?,
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('email', instance.email);
  writeNotNull('followers', instance.followers);
  writeNotNull('followings', instance.followings);
  writeNotNull('profileImage', instance.profileImage);
  writeNotNull('username', instance.username);
  writeNotNull('name', instance.name);
  writeNotNull('bio', instance.bio);
  return val;
}
