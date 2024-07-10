import 'package:flutter/material.dart';

import '../../domain/repositories/media_repository.dart';
import '../services/media/media_service.dart';

class MediaRepositoryImp implements MediaRepository {
  MediaRepositoryImp(this.mediaService);

  final MediaService mediaService;
  @override
  Future<FileImage?> uploadFromCamera() async {
    return mediaService.uploadFromCamera();
  }

  @override
  Future<FileImage?> uploadFromGallery() async {
    return mediaService.uploadFromGallery();
  }
}
