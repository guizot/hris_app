import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hantera/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:hantera/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:hantera/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hantera/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hantera/features/auth/domain/repositories/auth_repository.dart';
import 'package:hantera/features/auth/domain/usecases/sign_in.dart';
import 'package:hantera/features/auth/domain/usecases/sign_up.dart';
import 'package:hantera/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hantera/features/employee/data/datasources/employee_local_data_source.dart';
import 'package:hantera/features/employee/data/datasources/employee_local_data_source_impl.dart';
import 'package:hantera/features/employee/data/datasources/employee_remote_data_source.dart';
import 'package:hantera/features/employee/data/datasources/employee_remote_data_source_impl.dart';
import 'package:hantera/features/employee/data/repositories/employee_repository_impl.dart';
import 'package:hantera/features/employee/domain/repositories/employee_repository.dart';
import 'package:hantera/features/employee/domain/usecases/create_employee.dart';
import 'package:hantera/features/employee/domain/usecases/delete_employee.dart';
import 'package:hantera/features/employee/domain/usecases/get_all_employees.dart';
import 'package:hantera/features/employee/domain/usecases/get_employee_by_id.dart';
import 'package:hantera/features/employee/domain/usecases/search_employees.dart';
import 'package:hantera/features/employee/domain/usecases/update_employee.dart';
import 'package:hantera/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:hantera/features/employee/data/models/employee_model.dart';
import 'package:hantera/features/auth/data/models/user_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      signIn: sl(),
      signUp: sl(),
      authRepository: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Initialize Hive
  try {
    // Initialize Hive
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    
    // Register Hive adapters
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(EmployeeModelAdapter());
    
    // Initialize Auth Local DataSource
    final authLocalDataSource = AuthLocalDataSourceImpl();
    await authLocalDataSource.init();
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => authLocalDataSource,
    );
    
    // Initialize Employee Local DataSource
    final employeeLocalDataSource = EmployeeLocalDataSourceImpl();
    await employeeLocalDataSource.init();
    sl.registerLazySingleton<EmployeeLocalDataSource>(
      () => employeeLocalDataSource,
    );
    
    print('DEBUG: Hive initialized successfully');
  } catch (e) {
    print('DEBUG: Failed to initialize Hive: $e');
    rethrow;
  }

  // Employee Data Sources - Already registered above after initialization
  
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(),
  );

  // Employee Repositories
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Employee Use Cases
  sl.registerLazySingleton(() => GetAllEmployees(sl()));
  sl.registerLazySingleton(() => GetEmployeeById(sl()));
  sl.registerLazySingleton(() => CreateEmployee(sl()));
  sl.registerLazySingleton(() => UpdateEmployee(sl()));
  sl.registerLazySingleton(() => DeleteEmployee(sl()));
  sl.registerLazySingleton(() => SearchEmployees(sl()));

  // Employee BLoC
  sl.registerFactory(
    () => EmployeeBloc(
      getAllEmployees: sl(),
      getEmployeeById: sl(),
      createEmployee: sl(),
      updateEmployee: sl(),
      deleteEmployee: sl(),
      searchEmployees: sl(),
    ),
  );

  // External
}
