part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({this.error, this.userEntity, this.users});
  final String? error;
  final UserEntity? userEntity;
  final List<UserEntity>? users;
  @override
  List<Object?> get props => [error, UserEntity, users];
}

final class UserInitial extends UserState {}

final class UserDataDbUpdating extends UserState {
  UserDataDbUpdating(UserState initState)
      : super(userEntity: initState.userEntity, users: initState.users);
}

final class UserDataDbUpdated extends UserState {
  UserDataDbUpdated(UserEntity userEntity, UserState initState)
      : super(userEntity: userEntity, users: initState.users);
}

final class UserDataDbFailed extends UserState {
  UserDataDbFailed(String error, UserState initState)
      : super(
            error: error,
            userEntity: initState.userEntity,
            users: initState.users);
}

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
            users: initState.users);
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
