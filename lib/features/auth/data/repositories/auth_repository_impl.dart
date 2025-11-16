import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/exception.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:hantera/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hantera/features/auth/data/models/user_model.dart';
import 'package:hantera/features/auth/domain/entities/user.dart';
import 'package:hantera/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // First try to get user from local database
      final localUser = await localDataSource.getUser(email);
      
      if (localUser != null && localUser.password == password) {
        // Save current user session
        await localDataSource.saveCurrentUser(localUser);
        return Right(localUser);
      } else {
        return Left(ServerFailure('Invalid email or password'));
      }
    } on CacheException {
      return Left(CacheFailure('Failed to access local storage'));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Check if user already exists in local database
      final existingUser = await localDataSource.getUser(email);
      
      if (existingUser != null) {
        return Left(ServerFailure('User with this email already exists'));
      }
      
      // Create new user with unique ID
      final newUser = UserModel.fromAuth(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password,
      );
      
      // Save user to local database
      await localDataSource.saveUser(newUser);
      
      // Save current user session
      await localDataSource.saveCurrentUser(newUser);
      
      return Right(newUser);
    } on CacheException {
      return Left(CacheFailure('Failed to save user to local storage'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearCurrentUser();
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure('Failed to clear user session'));
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return await localDataSource.getCurrentUser();
    } on CacheException {
      return null;
    }
  }
}
