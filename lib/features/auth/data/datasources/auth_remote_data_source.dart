import 'package:hantera/core/error/exception.dart';
import 'package:hantera/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com') {
      return const UserModel(id: '1', name: 'Test User', email: 'test@test.com', password: 'password');
    } else {
      throw ServerException('Invalid credentials');
    }
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com') {
      return UserModel(id: '1', name: name, email: email, password: password);
    } else {
      throw ServerException('Email already exists');
    }
  }
}
