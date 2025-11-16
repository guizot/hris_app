import 'package:hantera/core/error/exception.dart';
import 'package:hantera/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hantera/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any email with password "password"
    if (password == 'password') {
      return UserModel(
        id: '1',
        name: 'Demo User',
        email: email,
        password: password,
      );
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
    
    // For demo purposes, check if user already exists
    // In a real app, this would make an API call
    
    if (email == 'demo@company.com') {
      throw ServerException('Email already exists');
    }
    
    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password,
    );
  }
}