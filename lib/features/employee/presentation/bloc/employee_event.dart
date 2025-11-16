part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class GetEmployeesEvent extends EmployeeEvent {
  const GetEmployeesEvent();
}

class GetEmployeeByIdEvent extends EmployeeEvent {
  final String id;

  const GetEmployeeByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreateEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  const CreateEmployeeEvent(this.employee);

  @override
  List<Object> get props => [employee];
}

class UpdateEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  const UpdateEmployeeEvent(this.employee);

  @override
  List<Object> get props => [employee];
}

class DeleteEmployeeEvent extends EmployeeEvent {
  final String id;

  const DeleteEmployeeEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SearchEmployeesEvent extends EmployeeEvent {
  final String query;

  const SearchEmployeesEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearchEvent extends EmployeeEvent {
  const ClearSearchEvent();
}