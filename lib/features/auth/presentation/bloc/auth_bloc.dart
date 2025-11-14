import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app/features/auth/domain/usecases/sign_in.dart';
import 'package:hris_app/features/auth/domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;

  AuthBloc({
    required this.signIn,
    required this.signUp,
  }) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signIn(
        SignInParams(
          email: event.email,
          password: event.password,
        ),
      );
      result.fold(
        (failure) => emit(const AuthFailure(message: 'Sign in failed')),
        (user) => emit(const AuthSuccess(message: 'Sign in successful')),
      );
    });
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signUp(
        SignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      result.fold(
        (failure) => emit(const AuthFailure(message: 'Sign up failed')),
        (user) => emit(const AuthSuccess(message: 'Sign up successful')),
      );
    });
  }
}
