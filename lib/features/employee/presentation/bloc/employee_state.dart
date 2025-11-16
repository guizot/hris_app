part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {
  const EmployeeInitial();
}

class EmployeeLoading extends EmployeeState {
  const EmployeeLoading();
}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  const EmployeeLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

class EmployeeDetailsLoaded extends EmployeeState {
  final Employee employee;

  const EmployeeDetailsLoaded(this.employee);

  @override
  List<Object> get props => [employee];
}

class EmployeeSearchLoaded extends EmployeeState {
  final List<Employee> employees;

  const EmployeeSearchLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

class EmployeeOperationSuccess extends EmployeeState {
  final String message;

  const EmployeeOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class EmployeeFailure extends EmployeeState {
  final String message;

  const EmployeeFailure(this.message);

  @override
  List<Object> get props => [message];
}