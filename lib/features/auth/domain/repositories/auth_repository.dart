
import 'package:hantera/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hantera/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
  
  Future<User?> getCurrentUser();
}
