import 'package:get_it/get_it.dart';
import 'package:hris_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hris_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hris_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hris_app/features/auth/domain/usecases/sign_in.dart';
import 'package:hris_app/features/auth/domain/usecases/sign_up.dart';
import 'package:hris_app/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void init() {
  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      signIn: sl(),
      signUp: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // External
}
