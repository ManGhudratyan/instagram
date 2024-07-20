part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent(
      {this.userEntity, this.userId, this.newFollowers, this.newFollowings});
  final UserEntity? userEntity;
  final List<String>? newFollowers;
  final List<String>? newFollowings;
  final String? userId;

  @override
  List<Object?> get props => [userEntity, newFollowers, userId, newFollowings];
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
  const RemoveFollowerFromDbEvent(this.userId, this.followerId);
  final String userId;
  final String followerId;

  @override
  List<Object> get props => [userId, followerId];
}

class AddFollowingsToDbEvent extends UserEvent {
  const AddFollowingsToDbEvent(String userId, List<String> newFollowings)
      : super(userId: userId, newFollowings: newFollowings);
}

class RemoveFollowingsFromDbEvent extends UserEvent {
  const RemoveFollowingsFromDbEvent(this.userId, this.followingId);
  final String userId;
  final String followingId;

  @override
  List<Object> get props => [userId, followingId];
}

class GetFollowingListEvent extends UserEvent {
  GetFollowingListEvent(this.userId);

  final String userId;
}

class FetchUserEvent extends UserEvent {
  const FetchUserEvent({required this.userId});
  final String userId;
}

class LoadUserDataEvent extends UserEvent {}
