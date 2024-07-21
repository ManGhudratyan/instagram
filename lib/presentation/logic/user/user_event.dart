// ignore_for_file: overridden_fields

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
  @override
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
  @override
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
  @override
  final String userId;
  final String followerId;

  @override
  List<Object> get props => [userId, followerId];
}

class AddFollowingsToDbEvent extends UserEvent {
  final String userId;
  final List<String> newFollowings;

  AddFollowingsToDbEvent(this.userId, this.newFollowings);
}

class RemoveFollowingFromDbEvent extends UserEvent {
  final String userId;
  final String followingId;

  RemoveFollowingFromDbEvent(this.userId, this.followingId);
}

class GetFollowingListEvent extends UserEvent {
  const GetFollowingListEvent(this.userId);

  @override
  final String userId;
}

class FetchUserEvent extends UserEvent {
  const FetchUserEvent({required this.userId});
  @override
  final String userId;
}

class LoadUserDataEvent extends UserEvent {}
