import 'package:hive/hive.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 1)
class EmployeeModel extends Employee {
  @HiveField(0)
  @override
  final String id;
  
  @HiveField(1)
  @override
  final String name;
  
  @HiveField(2)
  @override
  final String email;
  
  @HiveField(3)
  @override
  final String phone;
  
  @HiveField(4)
  @override
  final String department;
  
  @HiveField(5)
  @override
  final String designation;
  
  @HiveField(6)
  @override
  final DateTime hireDate;
  
  @HiveField(7)
  @override
  final String? profilePicture;
  const EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.designation,
    required this.hireDate,
    this.profilePicture,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          department: department,
          designation: designation,
          hireDate: hireDate,
          profilePicture: profilePicture,
        );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      department: json['department'] as String,
      designation: json['designation'] as String,
      hireDate: DateTime.parse(json['hireDate'] as String),
      profilePicture: json['profilePicture'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'department': department,
      'designation': designation,
      'hireDate': hireDate.toIso8601String(),
      'profilePicture': profilePicture,
    };
  }

  factory EmployeeModel.fromEntity(Employee employee) {
    return EmployeeModel(
      id: employee.id,
      name: employee.name,
      email: employee.email,
      phone: employee.phone,
      department: employee.department,
      designation: employee.designation,
      hireDate: employee.hireDate,
      profilePicture: employee.profilePicture,
    );
  }
}