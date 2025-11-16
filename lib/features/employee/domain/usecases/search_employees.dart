import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/core/usecases/usecase.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/features/employee/domain/repositories/employee_repository.dart';

class SearchEmployees extends UseCase<List<Employee>, String> {
  final EmployeeRepository repository;

  SearchEmployees(this.repository);

  @override
  Future<Either<Failure, List<Employee>>> call(String params) {
    return repository.searchEmployees(params);
  }
}