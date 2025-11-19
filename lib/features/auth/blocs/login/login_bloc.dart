import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_event.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_state.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteRepository _authRemoteRepository;
  LoginBloc(this._authRemoteRepository) : super(LoginInitialState()) {
    on<LoginSubmittedEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final response = await _authRemoteRepository.login(
          event.email,
          event.password,
        );
        emit(LoginSuccessState(response));
      } on CreateException catch (e) {
        emit(LoginFailureState(e.error));
      } catch (e) {
        emit(
          LoginFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.loginFailureMessage,
            ),
          ),
        );
      }
    });
  }
}
