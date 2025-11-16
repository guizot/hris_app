import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/core/usecases/usecase.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/features/employee/domain/repositories/employee_repository.dart';

class GetAllEmployees extends UseCase<List<Employee>, NoParams> {
  final EmployeeRepository repository;

  GetAllEmployees(this.repository);

  @override
  Future<Either<Failure, List<Employee>>> call(NoParams params) {
    return repository.getEmployees();
  }
}