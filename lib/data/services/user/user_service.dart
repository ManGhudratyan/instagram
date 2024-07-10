import 'dart:io';
import '../../models/user_model.dart';

abstract class UserService {
  Future<void> saveUserToDB(UserModel userModel);
  Future<UserModel> getUserFromDb(String userId);
  Future<void> uploadProfilePicture(String userId, File file);
}
