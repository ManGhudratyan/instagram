part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({this.error, this.userModel, this.users});
  final String? error;
  final UserModel? userModel;
  final List<UserModel>? users;
  @override
  List<Object?> get props => [error, userModel, users];
}

final class UserInitial extends UserState {}

final class UserDataDbUpdating extends UserState {
  UserDataDbUpdating(UserState initState)
      : super(userModel: initState.userModel, users: initState.users);
}

final class UserDataDbUpdated extends UserState {
  UserDataDbUpdated(UserModel userModel, UserState initState)
      : super(userModel: userModel, users: initState.users);
}

final class UserDataDbFailed extends UserState {
  UserDataDbFailed(String error, UserState initState)
      : super(
            error: error,
            userModel: initState.userModel,
            users: initState.users);
}

final class GetUserDataLoading extends UserState {
  GetUserDataLoading(UserState initState)
      : super(userModel: initState.userModel, users: initState.users);
}

final class GetUserDataLoaded extends UserState {
  GetUserDataLoaded(UserModel userModel, UserState initState)
      : super(userModel: userModel, users: initState.users);
}

final class GetUserDataFailed extends UserState {
  GetUserDataFailed(String error, UserState initState)
      : super(
            error: error,
            userModel: initState.userModel,
            users: initState.users);
}

final class UserFailed extends UserState {
  UserFailed(UserState initialState, String error)
      : super(userModel: initialState.userModel, error: error);
}

final class UserLoading extends UserState {
  UserLoading(UserState initialState)
      : super(userModel: initialState.userModel);
}

final class UserLoaded extends UserState {
  UserLoaded(UserModel? model, UserState initState)
      : super(userModel: model, users: initState.users);
}

final class GetUsersFromCollectionLoaded extends UserState {
  GetUsersFromCollectionLoaded(UserState initState, List<UserModel> users)
      : super(users: users, userModel: initState.userModel);
}

final class GetUsersFromCollectionLoading extends UserState {
  GetUsersFromCollectionLoading(UserState initialState)
      : super(userModel: initialState.userModel);
}

final class GetUsersFromCollectionFailed extends UserState {
  GetUsersFromCollectionFailed(String error, UserState initState)
      : super(
          error: error,
          userModel: initState.userModel,
          users: initState.users,
        );
}
