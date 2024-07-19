part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent({this.userEntity, this.userId, this.newFollowers});
  final UserEntity? userEntity;
  final List<String>? newFollowers;
  final String? userId;

  @override
  List<Object?> get props => [userEntity, newFollowers, userId];
}

final class UpdateUserDataEvent extends UserEvent {
  const UpdateUserDataEvent(this.userEntity, {this.file});
  final File? file;
  final UserEntity userEntity;
}

final class GetUserDataEvent extends UserEvent {
  const GetUserDataEvent(String userId) : super(userId: userId);
}

final class GetUserByIdEvent extends UserEvent {
  const GetUserByIdEvent(String userId) : super(userId: userId);
}

class UploadProfilePhotoEvent extends UserEvent {
  const UploadProfilePhotoEvent(this.userId, this.file);
  final String userId;
  final File file;
}

class GetUsersCollectionEvent extends UserEvent {}

class AddFollowersToDbEvent extends UserEvent {
  const AddFollowersToDbEvent(String userId, List<String> newFollowers)
      : super(userId: userId, newFollowers: newFollowers);
}

class RemoveFollowerFromDbEvent extends UserEvent {
  final String userId;
  final String followerId;

  const RemoveFollowerFromDbEvent(this.userId, this.followerId);

  @override
  List<Object> get props => [userId, followerId];
}