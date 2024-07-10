import 'package:flutter/material.dart';

abstract class MediaService {
  Future<FileImage?> uploadFromCamera();
  Future<FileImage?> uploadFromGallery();
}
