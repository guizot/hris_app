import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/core/usecases/usecase.dart';
import 'package:hantera/features/employee/domain/repositories/employee_repository.dart';

class DeleteEmployee extends UseCase<void, String> {
  final EmployeeRepository repository;

  DeleteEmployee(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.deleteEmployee(params);
  }
}