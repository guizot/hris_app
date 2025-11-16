import 'package:hantera/features/employee/data/models/employee_model.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<EmployeeModel>> fetchEmployees();
  Future<EmployeeModel> fetchEmployeeById(String id);
  Future<EmployeeModel> createEmployee(EmployeeModel employee);
  Future<EmployeeModel> updateEmployee(EmployeeModel employee);
  Future<void> deleteEmployee(String id);
  Future<List<EmployeeModel>> searchEmployees(String query);
}