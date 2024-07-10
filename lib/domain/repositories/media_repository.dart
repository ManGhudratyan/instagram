import 'package:flutter/material.dart';

abstract class MediaRepository {
  Future<FileImage?> uploadFromCamera();
  Future<FileImage?> uploadFromGallery();
}
