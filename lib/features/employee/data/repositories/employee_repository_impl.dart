import 'package:dartz/dartz.dart';
import 'package:hantera/core/error/exception.dart';
import 'package:hantera/core/error/failure.dart';
import 'package:hantera/features/employee/data/datasources/employee_local_data_source.dart';
import 'package:hantera/features/employee/data/datasources/employee_remote_data_source.dart';
import 'package:hantera/features/employee/data/models/employee_model.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/features/employee/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;
  final EmployeeLocalDataSource localDataSource;

  EmployeeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    try {
      final remoteEmployees = await remoteDataSource.fetchEmployees();
      await localDataSource.cacheEmployees(remoteEmployees);
      return Right(remoteEmployees);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Employee>> getEmployeeById(String id) async {
    try {
      final remoteEmployee = await remoteDataSource.fetchEmployeeById(id);
      await localDataSource.cacheEmployee(remoteEmployee);
      return Right(remoteEmployee);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Employee>> createEmployee(Employee employee) async {
    try {
      final employeeModel = EmployeeModel.fromEntity(employee);
      final createdEmployee = await remoteDataSource.createEmployee(employeeModel);
      await localDataSource.cacheEmployee(createdEmployee);
      return Right(createdEmployee);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Employee>> updateEmployee(Employee employee) async {
    try {
      final employeeModel = EmployeeModel.fromEntity(employee);
      final updatedEmployee = await remoteDataSource.updateEmployee(employeeModel);
      await localDataSource.cacheEmployee(updatedEmployee);
      return Right(updatedEmployee);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(String id) async {
    try {
      await remoteDataSource.deleteEmployee(id);
      await localDataSource.deleteCachedEmployee(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Employee>>> searchEmployees(String query) async {
    try {
      final searchResults = await remoteDataSource.searchEmployees(query);
      return Right(searchResults);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }
}