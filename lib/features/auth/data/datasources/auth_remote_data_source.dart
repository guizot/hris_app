import 'package:hris_app/features/auth/data/models/user_model.dart';

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
    // TODO: Implement signIn
    await Future.delayed(const Duration(seconds: 1));
    return const UserModel(id: '1', name: 'Test User', email: 'test@test.com');
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    // TODO: Implement signUp
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(id: '1', name: name, email: email);
  }
}
