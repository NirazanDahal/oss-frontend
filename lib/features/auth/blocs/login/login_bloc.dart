import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/features/auth/services/auth_service.dart';
import 'package:oss_frontend/features/auth/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final AuthService _authService;

  LoginBloc({
    required LoginUseCase loginUseCase,
    required AuthService authService,
  })  : _loginUseCase = loginUseCase,
        _authService = authService,
        super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await _loginUseCase(
        email: event.email,
        password: event.password,
      );

      if (response.success && response.token != null && response.user != null) {
        await _authService.saveUserSession(
          token: response.token!,
          id: response.user!.id,
          name: response.user!.name,
          email: response.user!.email,
        );
        emit(LoginSuccess(response.user!));
      } else {
        emit(LoginFailure(response.error ?? 'Login failed'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}