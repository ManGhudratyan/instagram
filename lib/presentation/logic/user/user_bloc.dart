import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user/user_model.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UpdateUserDataEvent>(_mapUpdateUserDataEventToState);
    on<GetUserDataEvent>(_mapGetUserDataEventToState);
    on<UploadProfilePhotoEvent>(_mapUploadProfilePhotoEventToState);
    on<GetUsersCollectionEvent>(_mapGetUsersCollectionEventToState);
    on<AddFollowersToDbEvent>(_mapAddFollowersToDbEventToState);
    on<RemoveFollowerFromDbEvent>(_mapRemoveFollowerFromDbEventToState);
    on<LoadUserDataEvent>(_mapLoadUserDataEventToState);
    on<AddFollowingsToDbEvent>(_mapAddFollowingsToDbEventToState);
    on<RemoveFollowingFromDbEvent>(_mapRemoveFollowingFromDbEventToState);
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
      emit(UserDataDbUpdated(state));
    } catch (error) {
      emit(UserDataDbFailed(error.toString(), state));
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

  FutureOr<void> _mapRemoveFollowerFromDbEventToState(
      RemoveFollowerFromDbEvent event, Emitter<UserState> emit) async {
    try {
      emit(RemoveFollowerFromDbLoading());
      await userRepository.removeFollower(event.userId, event.followerId);
      final updatedUser = await userRepository.getUserFromDb(event.userId);
      emit(RemoveFollowerFromDbLoaded(updatedUser.toModel(), state));
    } catch (error) {
      emit(RemoveFollowerFromDbFailed(error.toString()));
    }
  }

  FutureOr<void> _mapAddFollowersToDbEventToState(
      AddFollowersToDbEvent event, Emitter<UserState> emit) async {
    try {
      emit(AddFollowersToDbLoading());
      await userRepository.addFollowersList(
          event.userId ?? '', event.newFollowers ?? []);

      final updatedUser =
          await userRepository.getUserFromDb(event.userId ?? '');
      emit(AddFollowersToDbLoaded(state,updatedUser.followers ?? []));
    } catch (error) {
      emit(AddFollowersToDbFailed(error.toString()));
    }
  }

  FutureOr<void> _mapGetUserDataEventToState(
      GetUserDataEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(state));
      final user = await userRepository.getUserFromDb(event.userId ?? '');
      emit(UserLoaded(user.toModel(), state));
    } catch (error) {
      emit(UserFailed(state, error.toString()));
    }
  }

  FutureOr<void> _mapLoadUserDataEventToState(
      LoadUserDataEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(state));
      final user = await userRepository.getUserFromDb(event.userId ?? '');
      emit(UserLoaded(user.toModel(), state));
    } catch (error) {
      emit(UserFailed(state, error.toString()));
    }
  }

  FutureOr<void> _mapAddFollowingsToDbEventToState(
      AddFollowingsToDbEvent event, Emitter<UserState> emit) async {
    try {
      emit(AddFollowingsToDbLoading());
      await userRepository.addFollowingList(event.userId, event.newFollowings);
      final updatedUser = await userRepository.getUserFromDb(event.userId);
      if (event.userId == event.newFollowings.first) {
        await userRepository.addFollowersList(
            event.userId, event.newFollowings);
      }
      emit(AddFollowingsToDbLoaded(updatedUser.toModel()));
    } catch (error) {
      emit(AddFollowingToDbFailed(error.toString()));
    }
  }

  FutureOr<void> _mapRemoveFollowingFromDbEventToState(
      RemoveFollowingFromDbEvent event, Emitter<UserState> emit) async {
    try {
      emit(RemoveFollowingFromDbLoading());
      await userRepository.removeFollowing(event.userId, event.followingId);
      final updatedUser = await userRepository.getUserFromDb(event.userId);
      if (event.userId == event.followingId) {
        await userRepository.removeFollower(event.userId, event.followingId);
      }
      emit(RemoveFollowingFromDbLoaded(updatedUser.toModel()));
    } catch (error) {
      emit(RemoveFollowingFromDbFailed(error.toString()));
    }
  }
}
