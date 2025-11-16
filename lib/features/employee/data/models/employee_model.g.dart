// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeModelAdapter extends TypeAdapter<EmployeeModel> {
  @override
  final int typeId = 1;

  @override
  EmployeeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeModel(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      phone: fields[3] as String,
      department: fields[4] as String,
      designation: fields[5] as String,
      hireDate: fields[6] as DateTime,
      profilePicture: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.department)
      ..writeByte(5)
      ..write(obj.designation)
      ..writeByte(6)
      ..write(obj.hireDate)
      ..writeByte(7)
      ..write(obj.profilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
