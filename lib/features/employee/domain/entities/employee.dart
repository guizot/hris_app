import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String designation;
  final DateTime hireDate;
  final String? profilePicture;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.designation,
    required this.hireDate,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        department,
        designation,
        hireDate,
        profilePicture,
      ];
}