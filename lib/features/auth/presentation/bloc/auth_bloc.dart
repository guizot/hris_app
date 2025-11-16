import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hantera/features/auth/domain/entities/user.dart';
import 'package:hantera/features/auth/domain/repositories/auth_repository.dart';
import 'package:hantera/features/auth/domain/usecases/sign_in.dart';
import 'package:hantera/features/auth/domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final AuthRepository authRepository;

  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      print('DEBUG: SignInEvent triggered with email: ${event.email}');
      emit(AuthLoading());
      try {
        final result = await signIn(
          SignInParams(
            email: event.email,
            password: event.password,
          ),
        );
        result.fold(
          (failure) {
            print('DEBUG: Sign in failed: ${failure.message}');
            emit(AuthFailure(message: failure.message));
          },
          (user) {
            print('DEBUG: Sign in successful for user: ${user.email}');
            emit(Authenticated(user: user));
          },
        );
      } catch (e) {
        print('DEBUG: Unexpected error during sign in: $e');
        emit(AuthFailure(message: 'An unexpected error occurred'));
      }
    });
    on<SignUpEvent>((event, emit) async {
      print('DEBUG: SignUpEvent triggered with email: ${event.email}, name: ${event.name}');
      emit(AuthLoading());
      try {
        final result = await signUp(
          SignUpParams(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );
        result.fold(
          (failure) {
            print('DEBUG: Sign up failed: ${failure.message}');
            emit(AuthFailure(message: failure.message));
          },
          (user) {
            print('DEBUG: Sign up successful for user: ${user.email}');
            emit(Authenticated(user: user));
          },
        );
      } catch (e) {
        print('DEBUG: Unexpected error during sign up: $e');
        emit(AuthFailure(message: 'An unexpected error occurred'));
      }
    });
    
    on<CheckAuthEvent>((event, emit) async {
      print('DEBUG: CheckAuthEvent triggered');
      emit(AuthLoading());
      try {
        final currentUser = await authRepository.getCurrentUser();
        if (currentUser != null) {
          print('DEBUG: Found active session for user: ${currentUser.email}');
          emit(Authenticated(user: currentUser));
        } else {
          print('DEBUG: No active session found');
          emit(Unauthenticated());
        }
      } catch (e) {
        print('DEBUG: Error checking auth session: $e');
        emit(Unauthenticated());
      }
    });
    
    on<LogoutEvent>((event, emit) async {
      print('DEBUG: LogoutEvent triggered');
      emit(AuthLoading());
      try {
        final result = await authRepository.logout();
        result.fold(
          (failure) {
            print('DEBUG: Logout failed: ${failure.message}');
            emit(AuthFailure(message: failure.message));
          },
          (_) {
            print('DEBUG: Logout successful');
            emit(Unauthenticated());
          },
        );
      } catch (e) {
        print('DEBUG: Error during logout: $e');
        emit(Unauthenticated());
      }
    });
  }
}
