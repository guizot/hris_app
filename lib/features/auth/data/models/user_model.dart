import 'package:hive/hive.dart';
import 'package:hantera/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends User {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String email;
  
  @HiveField(3)
  final String password;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  }) : super(
          id: id,
          name: name,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
  
  factory UserModel.fromAuth({
    required String id,
    required String name,
    required String email,
    required String password,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      password: password,
    );
  }
}
