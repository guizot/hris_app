import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/core/usecases/usecase.dart';
import 'package:hantera/features/auth/domain/entities/user.dart';
import 'package:hantera/features/auth/domain/repositories/auth_repository.dart';

class SignIn implements UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignIn(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
