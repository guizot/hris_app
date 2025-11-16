import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/core/usecases/usecase.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/features/employee/domain/repositories/employee_repository.dart';

class GetEmployeeById extends UseCase<Employee, String> {
  final EmployeeRepository repository;

  GetEmployeeById(this.repository);

  @override
  Future<Either<Failure, Employee>> call(String params) {
    return repository.getEmployeeById(params);
  }
}