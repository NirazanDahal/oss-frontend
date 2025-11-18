import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/features/auth/usecases/register_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await _registerUseCase(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      if (response.success && response.user != null) {
        emit(RegisterSuccess(response.user!));
      } else {
        emit(RegisterFailure(response.error ?? 'Unknown error occurred'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}