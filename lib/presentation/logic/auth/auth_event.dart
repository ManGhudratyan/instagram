part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent({this.userEntity});
  final UserEntity? userEntity;

  @override
  List<Object?> get props => [userEntity];
}

final class LoginGoogleEvent extends AuthEvent {}
