import 'package:hive/hive.dart';
import 'package:hantera/core/error/exception.dart';
import 'package:hantera/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:hantera/features/auth/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  late Box<UserModel> _userBox;
  late Box<String> _sessionBox;
  static const String _userBoxName = 'users';
  static const String _sessionBoxName = 'session';

  @override
  Future<void> init() async {
    try {
      _userBox = await Hive.openBox<UserModel>(_userBoxName);
      _sessionBox = await Hive.openBox<String>(_sessionBoxName);
    } catch (e) {
      throw CacheException('Failed to initialize user cache: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await _userBox.put(user.email, user);
    } catch (e) {
      throw CacheException('Failed to save user: $e');
    }
  }

  @override
  Future<UserModel?> getUser(String email) async {
    try {
      return _userBox.get(email);
    } catch (e) {
      throw CacheException('Failed to get user: $e');
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      return _userBox.values.toList();
    } catch (e) {
      throw CacheException('Failed to get all users: $e');
    }
  }

  @override
  Future<void> clearAllUsers() async {
    try {
      await _userBox.clear();
    } catch (e) {
      throw CacheException('Failed to clear users: $e');
    }
  }

  @override
  Future<void> saveCurrentUser(UserModel user) async {
    try {
      await _sessionBox.put('current_user_email', user.email);
    } catch (e) {
      throw CacheException('Failed to save current user session: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final currentUserEmail = _sessionBox.get('current_user_email');
      if (currentUserEmail != null) {
        return await getUser(currentUserEmail);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get current user session: $e');
    }
  }

  @override
  Future<void> clearCurrentUser() async {
    try {
      await _sessionBox.clear();
    } catch (e) {
      throw CacheException('Failed to clear current user session: $e');
    }
  }
}