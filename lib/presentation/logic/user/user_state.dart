// ignore_for_file: overridden_fields, avoid_unused_constructor_parameters

part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState(
      {this.error, this.userEntity, this.users, this.updatedFollowers});
  final String? error;
  final UserEntity? userEntity;
  final List<UserEntity>? users;
  final List<String>? updatedFollowers;

  @override
  List<Object?> get props => [error, userEntity, users, updatedFollowers];
}

final class UserInitial extends UserState {}

final class GetUserDataLoading extends UserState {
  GetUserDataLoading(UserState initState)
      : super(userEntity: initState.userEntity, users: initState.users);
}

final class GetUserDataLoaded extends UserState {
  GetUserDataLoaded(UserEntity userEntity, UserState initState)
      : super(userEntity: userEntity, users: initState.users);
}

final class GetUserDataFailed extends UserState {
  GetUserDataFailed(String error, UserState initState)
      : super(
          error: error,
          userEntity: initState.userEntity,
          users: initState.users,
        );
}

final class UserFailed extends UserState {
  UserFailed(UserState initialState, String error)
      : super(userEntity: initialState.userEntity, error: error);
}

final class UserLoading extends UserState {
  UserLoading(UserState initialState)
      : super(userEntity: initialState.userEntity);
}

final class UserLoaded extends UserState {
  UserLoaded(UserEntity? userEntity, UserState initState)
      : super(userEntity: userEntity, users: initState.users);
}

final class GetUsersFromCollectionLoaded extends UserState {
  GetUsersFromCollectionLoaded(UserState initState, List<UserEntity> users)
      : super(users: users, userEntity: initState.userEntity);
}

final class GetUsersFromCollectionLoading extends UserState {
  GetUsersFromCollectionLoading(UserState initialState)
      : super(userEntity: initialState.userEntity);
}

final class GetUsersFromCollectionFailed extends UserState {
  GetUsersFromCollectionFailed(String error, UserState initState)
      : super(
          error: error,
          userEntity: initState.userEntity,
          users: initState.users,
        );
}

final class UserDataDbUpdating extends UserState {
  UserDataDbUpdating(UserState initialState)
      : super(userEntity: initialState.userEntity, users: initialState.users);
}

final class UserDataDbUpdated extends UserState {
  UserDataDbUpdated(UserState initialState)
      : super(userEntity: initialState.userEntity, users: initialState.users);
}

class UserDataDbFailed extends UserState {
  const UserDataDbFailed(this.error, this.initState);
  @override
  final String error;
  final UserState initState;
}

final class AddFollowingsToDbLoading extends UserState {}

class AddFollowersToDbLoaded extends UserState {
  AddFollowersToDbLoaded(UserState initState, List<String> updatedFollowers)
      : super(
          updatedFollowers: initState.updatedFollowers,
        );
}

class RemoveFollowerFromDbLoading extends UserState {}

class RemoveFollowerFromDbLoaded extends UserState {
  RemoveFollowerFromDbLoaded(UserModel userModel, UserState initState)
      : super(userEntity: initState.userEntity);
  // final UserModel userModel;
  // final UserState initState;
}

class RemoveFollowerFromDbFailed extends UserState {
  const RemoveFollowerFromDbFailed(String error) : super(error: error);
}

class UserFollowingListLoaded extends UserState {
  const UserFollowingListLoaded(this.followingList);
  final List<UserEntity> followingList;
}

final class AddFollowersToDbLoading extends UserState {}

final class AddFollowersToDbFailed extends UserState {
  const AddFollowersToDbFailed(String error) : super(error: error);
}

class AddFollowingsToDbLoaded extends UserState {
  const AddFollowingsToDbLoaded(this.userModel);
  final UserModel userModel;
}

class AddFollowingToDbFailed extends UserState {
  const AddFollowingToDbFailed(this.error);
  @override
  final String error;
}

class RemoveFollowingFromDbLoading extends UserState {}

class RemoveFollowingFromDbLoaded extends UserState {
  const RemoveFollowingFromDbLoaded(this.userModel);
  final UserModel userModel;
}

class RemoveFollowingFromDbFailed extends UserState {
  const RemoveFollowingFromDbFailed(this.error);
  @override
  final String error;
}
