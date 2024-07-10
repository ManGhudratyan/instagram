import 'package:json_annotation/json_annotation.dart';

import '../../data/models/user_model.dart';

class UserEntity {
  UserEntity({
    this.userId,
    this.email,
    this.followers,
    this.followings,
    this.profileImage,
    this.username,
    this.name,
    this.bio,
  });

  factory UserEntity.fromModel(UserModel userModel) {
    return UserEntity(
      userId: userModel.userId,
      email: userModel.email,
      followers: userModel.followers,
      followings: userModel.followings,
      profileImage: userModel.profileImage,
      username: userModel.username,
      name: userModel.name,
      bio: userModel.bio,
    );
  }
  UserModel toModel() {
    return UserModel(
      userId: userId,
      email: email,
      followers: followers,
      followings: followings,
      profileImage: profileImage,
      username: username,
      name: name,
      bio: bio,
    );
  }

  @JsonKey(includeIfNull: false)
  final String? userId;
  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(includeIfNull: false)
  final List<String>? followers;
  @JsonKey(includeIfNull: false)
  final List<String>? followings;
  @JsonKey(includeIfNull: false)
  final String? profileImage;
  @JsonKey(includeIfNull: false)
  final String? username;
  @JsonKey(includeIfNull: false)
  final String? name;
  @JsonKey(includeIfNull: false)
  final String? bio;
}
