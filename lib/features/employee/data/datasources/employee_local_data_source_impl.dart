import 'package:hive/hive.dart';
import 'package:hantera/core/error/exception.dart';
import 'package:hantera/features/employee/data/datasources/employee_local_data_source.dart';
import 'package:hantera/features/employee/data/models/employee_model.dart';

class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  static const String _employeesBoxName = 'employees';
  late Box<EmployeeModel> _employeesBox;

  Future<void> init() async {
    try {
      _employeesBox = await Hive.openBox<EmployeeModel>(_employeesBoxName);
    } catch (e) {
      throw CacheException('Failed to initialize employee cache: $e');
    }
  }

  @override
  Future<List<EmployeeModel>> getCachedEmployees() async {
    try {
      final employees = _employeesBox.values.toList();
      return employees;
    } catch (e) {
      throw CacheException('Failed to get cached employees: $e');
    }
  }

  @override
  Future<void> cacheEmployees(List<EmployeeModel> employees) async {
    try {
      await _employeesBox.clear();
      for (final employee in employees) {
        await _employeesBox.put(employee.id, employee);
      }
    } catch (e) {
      throw CacheException('Failed to cache employees: $e');
    }
  }

  @override
  Future<void> cacheEmployee(EmployeeModel employee) async {
    try {
      await _employeesBox.put(employee.id, employee);
    } catch (e) {
      throw CacheException('Failed to cache employee: $e');
    }
  }

  @override
  Future<void> deleteCachedEmployee(String id) async {
    try {
      await _employeesBox.delete(id);
    } catch (e) {
      throw CacheException('Failed to delete cached employee: $e');
    }
  }

  @override
  Future<void> clearAllEmployees() async {
    try {
      await _employeesBox.clear();
    } catch (e) {
      throw CacheException('Failed to clear employees cache: $e');
    }
  }
}