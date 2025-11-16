import 'package:hantera/features/employee/data/models/employee_model.dart';

abstract class EmployeeLocalDataSource {
  Future<List<EmployeeModel>> getCachedEmployees();
  Future<void> cacheEmployees(List<EmployeeModel> employees);
  Future<void> cacheEmployee(EmployeeModel employee);
  Future<void> deleteCachedEmployee(String id);
  Future<void> clearAllEmployees();
}