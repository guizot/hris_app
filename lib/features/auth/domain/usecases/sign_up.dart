import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app/core/error/failure.dart';
import 'package:hris_app/core/usecases/usecase.dart';
import 'package:hris_app/features/auth/domain/entities/user.dart';
import 'package:hris_app/features/auth/domain/repositories/auth_repository.dart';

class SignUp implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
