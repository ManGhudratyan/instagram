part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent({this.userEntity, this.userId});
  final UserEntity? userEntity;
  final String? userId;

  @override
  List<Object?> get props => [userEntity];
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
