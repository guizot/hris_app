import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployees();
  Future<Either<Failure, Employee>> getEmployeeById(String id);
  Future<Either<Failure, Employee>> createEmployee(Employee employee);
  Future<Either<Failure, Employee>> updateEmployee(Employee employee);
  Future<Either<Failure, void>> deleteEmployee(String id);
  Future<Either<Failure, List<Employee>>> searchEmployees(String query);
}