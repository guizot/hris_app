import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hantera/core/usecases/usecase.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/features/employee/domain/usecases/create_employee.dart';
import 'package:hantera/features/employee/domain/usecases/delete_employee.dart';
import 'package:hantera/features/employee/domain/usecases/get_all_employees.dart';
import 'package:hantera/features/employee/domain/usecases/get_employee_by_id.dart';
import 'package:hantera/features/employee/domain/usecases/search_employees.dart';
import 'package:hantera/features/employee/domain/usecases/update_employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetAllEmployees getAllEmployees;
  final GetEmployeeById getEmployeeById;
  final CreateEmployee createEmployee;
  final UpdateEmployee updateEmployee;
  final DeleteEmployee deleteEmployee;
  final SearchEmployees searchEmployees;

  EmployeeBloc({
    required this.getAllEmployees,
    required this.getEmployeeById,
    required this.createEmployee,
    required this.updateEmployee,
    required this.deleteEmployee,
    required this.searchEmployees,
  }) : super(EmployeeInitial()) {
    on<GetEmployeesEvent>(_onGetEmployees);
    on<GetEmployeeByIdEvent>(_onGetEmployeeById);
    on<CreateEmployeeEvent>(_onCreateEmployee);
    on<UpdateEmployeeEvent>(_onUpdateEmployee);
    on<DeleteEmployeeEvent>(_onDeleteEmployee);
    on<SearchEmployeesEvent>(_onSearchEmployees);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onGetEmployees(
    GetEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await getAllEmployees(NoParams());
    result.fold(
      (failure) => emit(EmployeeFailure(failure.message)),
      (employees) => emit(EmployeeLoaded(employees)),
    );
  }

  Future<void> _onGetEmployeeById(
    GetEmployeeByIdEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await getEmployeeById(event.id);
    result.fold(
      (failure) => emit(EmployeeFailure(failure.message)),
      (employee) => emit(EmployeeDetailsLoaded(employee)),
    );
  }

  Future<void> _onCreateEmployee(
    CreateEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await createEmployee(event.employee);
    result.fold(
      (failure) => emit(EmployeeFailure(failure.message)),
      (employee) => emit(EmployeeOperationSuccess('Employee created successfully')),
    );
  }

  Future<void> _onUpdateEmployee(
    UpdateEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await updateEmployee(event.employee);
    result.fold(
      (failure) => emit(EmployeeFailure(failure.message)),
      (employee) => emit(EmployeeOperationSuccess('Employee updated successfully')),
    );
  }

  Future<void> _onDeleteEmployee(
    DeleteEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await deleteEmployee(event.id);
    result.fold(
      (failure) => emit(EmployeeFailure(failure.message)),
      (_) => emit(EmployeeOperationSuccess('Employee deleted successfully')),
    );
  }

  Future<void> _onSearchEmployees(
    SearchEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    final result = await searchEmployees(event.query);
    result.fold(
      (failure) => emit(EmployeeFailure(failure.message)),
      (employees) => emit(EmployeeSearchLoaded(employees)),
    );
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeInitial());
  }
}