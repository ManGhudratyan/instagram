import 'dart:io';

import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<void> saveUserToDB(UserEntity userEntity);
Future<void> uploadProfilePicture(String userId, File file);
  Future<UserModel> getUserFromDb(String userId);
  
}
