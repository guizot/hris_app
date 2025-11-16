import 'package:hantera/core/error/exception.dart';
import 'package:hantera/core/mocks/mock_data.dart';
import 'package:hantera/features/employee/data/datasources/employee_remote_data_source.dart';
import 'package:hantera/features/employee/data/models/employee_model.dart';

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  @override
  Future<List<EmployeeModel>> fetchEmployees() async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.employees;
  }

  @override
  Future<EmployeeModel> fetchEmployeeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final employee = MockData.employees.firstWhere((e) => e.id == id);
      return employee;
    } catch (e) {
      throw ServerException('Employee not found');
    }
  }

  @override
  Future<EmployeeModel> createEmployee(EmployeeModel employee) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would send data to a server
    // For mock, we'll just return the employee with a new ID
    final newEmployee = EmployeeModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: employee.name,
      email: employee.email,
      phone: employee.phone,
      department: employee.department,
      designation: employee.designation,
      hireDate: employee.hireDate,
      profilePicture: employee.profilePicture,
    );
    MockData.employees.add(newEmployee);
    return newEmployee;
  }

  @override
  Future<EmployeeModel> updateEmployee(EmployeeModel employee) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final index = MockData.employees.indexWhere((e) => e.id == employee.id);
      if (index == -1) {
        throw ServerException('Employee not found');
      }
      MockData.employees[index] = employee;
      return employee;
    } catch (e) {
      throw ServerException('Failed to update employee');
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      MockData.employees.removeWhere((e) => e.id == id);
    } catch (e) {
      throw ServerException('Failed to delete employee');
    }
  }

  @override
  Future<List<EmployeeModel>> searchEmployees(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) {
      return MockData.employees;
    }
    
    final lowerQuery = query.toLowerCase();
    return MockData.employees.where((employee) {
      return employee.name.toLowerCase().contains(lowerQuery) ||
          employee.email.toLowerCase().contains(lowerQuery) ||
          employee.department.toLowerCase().contains(lowerQuery) ||
          employee.designation.toLowerCase().contains(lowerQuery) ||
          employee.id == query;
    }).toList();
  }
}