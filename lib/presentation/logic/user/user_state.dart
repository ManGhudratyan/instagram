// ignore_for_file: overridden_fields

part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({this.error, this.userEntity, this.users});
  final String? error;
  final UserEntity? userEntity;
  final List<UserEntity>? users;
  @override
  List<Object?> get props => [error, userEntity, users];
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

class RemoveFollowerFromDbLoading extends UserState {}

class RemoveFollowerFromDbLoaded extends UserState {
  const RemoveFollowerFromDbLoaded(this.userModel, this.initState);
  final UserModel userModel;
  final UserState initState;
}

class RemoveFollowerFromDbFailed extends UserState {
  const RemoveFollowerFromDbFailed(String error) : super(error: error);
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
  const AddFollowersToDbLoaded(this.updatedFollowers);
  final List<String> updatedFollowers;

  @override
  List<Object?> get props => [updatedFollowers];
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
  final UserModel userModel;

  AddFollowingsToDbLoaded(this.userModel);
}

class AddFollowingToDbFailed extends UserState {
  final String error;

  AddFollowingToDbFailed(this.error);
}

class RemoveFollowingFromDbLoading extends UserState {}

class RemoveFollowingFromDbLoaded extends UserState {
  final UserModel userModel;

  RemoveFollowingFromDbLoaded(this.userModel);
}

class RemoveFollowingFromDbFailed extends UserState {
  final String error;

  RemoveFollowingFromDbFailed(this.error);
}
