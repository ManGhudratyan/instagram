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

final class UserDataDbUpdating extends UserState {}

final class UserDataDbUpdated extends UserState {
  const UserDataDbUpdated(UserModel userModel) : super(userModel: userModel);
}

final class UserDataDbFailed extends UserState {
  const UserDataDbFailed(String error) : super(error: error);
}

final class GetUserDataLoading extends UserState {}

final class GetUserDataLoaded extends UserState {
  const GetUserDataLoaded(UserModel userModel) : super(userModel: userModel);
}

final class GetUserDataFailed extends UserState {
  const GetUserDataFailed(String error) : super(error: error);
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
  const UserLoaded(UserModel? model) : super(userModel: model);
}

final class GetUsersFromCollectionLoaded extends UserState {
  const GetUsersFromCollectionLoaded(List<UserModel> users)
      : super(users: users);
}

final class GetUsersFromCollectionLoading extends UserState {}

final class GetUsersFromCollectionFailed extends UserState {
  const GetUsersFromCollectionFailed(String error) : super(error: error);
}
