import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user/user_model.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UpdateUserDataEvent>(_mapUpdateUserDataEventToState);
    on<GetUserDataEvent>(_mapGetUserDataEventToState);
    on<UploadProfilePhotoEvent>(_mapUploadProfilePhotoEventToState);
    on<GetUsersCollectionEvent>(_mapGetUsersCollectionEventToState);
  }

  final UserRepository userRepository;

  FutureOr<void> _mapUpdateUserDataEventToState(
      UpdateUserDataEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserDataDbUpdating(state));
      final userModel = event.userEntity.toModel();
      await userRepository.saveUserToDB(userModel);
      if (event.file != null) {
        await userRepository.uploadProfilePicture(
            event.userEntity.userId ?? '', event.file!);
      }
      emit(UserDataDbUpdated(userModel, state));
    } catch (error) {
      emit(UserDataDbFailed(state.error ?? '', state));
    }
  }

  // FutureOr<void> _mapGetUserDataEventToState(
  //     GetUserDataEvent event, Emitter<UserState> emit) async {
  //   try {
  //     emit(GetUserDataLoading(state));
  //     final users =
  //         await userRepository.getUserFromDb(event.userEntity?.userId ?? '');
  //     emit(GetUserDataLoaded(users.toModel(), state));
  //   } catch (error) {
  //     emit(GetUserDataFailed(error.toString(), state));
  //   }
  // }
  FutureOr<void> _mapGetUserDataEventToState(
    GetUserDataEvent event, Emitter<UserState> emit) async {
  try {
    emit(GetUserDataLoading(state));
    final users = await userRepository.getUserFromDb(event.userId ?? '');
    emit(GetUserDataLoaded(users.toModel(), state));
  } catch (error) {
    emit(GetUserDataFailed(error.toString(), state));
  }
}


  FutureOr<void> _mapUploadProfilePhotoEventToState(
      UploadProfilePhotoEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(state));
      await userRepository.uploadProfilePicture(event.userId, event.file);
      emit(UserLoaded(state.userEntity, state));
    } catch (e) {
      emit(UserFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapGetUsersCollectionEventToState(
      GetUsersCollectionEvent event, Emitter<UserState> emit) async {
    try {
      emit(GetUsersFromCollectionLoading(state));
      await for (final snapshot in userRepository.getUsersFromCollection()) {
        final users =
            snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
        emit(GetUsersFromCollectionLoaded(state, users));
      }
    } catch (error) {
      emit(GetUsersFromCollectionFailed(error.toString(), state));
    } 
  }
}
