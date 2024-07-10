import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    super.userId,
    super.email,
    super.followers,
    super.followings,
    super.bio,
    super.name,
    super.profileImage,
    super.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
