import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/media_repository.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc(this.mediaRepository) : super(MediaInitial()) {
    on<UploadPictureFromGalleryEvent>(_mapUploadPictureFromGalleryEventToState);
    on<UploadPictureFromCameraEvent>(_mapUploadPictureFromCameraEventToState);
  }
  final MediaRepository mediaRepository;

  FutureOr<void> _mapUploadPictureFromGalleryEventToState(
      UploadPictureFromGalleryEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      final fileImage = await mediaRepository.uploadFromGallery();
      emit(MediaLoaded(fileImage));
    } catch (error) {
      emit(MediaFailed(error.toString()));
    }
  }

  FutureOr<void> _mapUploadPictureFromCameraEventToState(
      UploadPictureFromCameraEvent event, Emitter<MediaState> emit) async {
    try {
      emit(MediaLoading());
      final fileImage = await mediaRepository.uploadFromCamera();
      if (fileImage != null) {
        emit(MediaLoaded(fileImage));
      }
    } catch (error) {
      emit(MediaFailed(error.toString()));
    }
  }
}
