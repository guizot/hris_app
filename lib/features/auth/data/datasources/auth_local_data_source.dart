import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hantera/core/error/exception.dart';
import 'package:hantera/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> init();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(String email);
  Future<List<UserModel>> getAllUsers();
  Future<void> clearAllUsers();
  Future<void> saveCurrentUser(UserModel user);
  Future<UserModel?> getCurrentUser();
  Future<void> clearCurrentUser();
}
