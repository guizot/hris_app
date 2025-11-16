import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/core/usecases/usecase.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/features/employee/domain/repositories/employee_repository.dart';

class CreateEmployee extends UseCase<Employee, Employee> {
  final EmployeeRepository repository;

  CreateEmployee(this.repository);

  @override
  Future<Either<Failure, Employee>> call(Employee params) {
    return repository.createEmployee(params);
  }
}