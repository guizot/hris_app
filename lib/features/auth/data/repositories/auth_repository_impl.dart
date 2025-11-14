import 'package:dartz/dartz.dart';
import 'package:hris_app/core/error/exception.dart';
import 'package:hris_app/core/error/failure.dart';
import 'package:hris_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hris_app/features/auth/domain/entities/user.dart';
import 'package:hris_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
