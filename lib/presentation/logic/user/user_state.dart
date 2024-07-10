part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({this.error, this.userModel});
  final String? error;
  final UserModel? userModel;
  @override
  List<Object?> get props => [error, userModel];
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
