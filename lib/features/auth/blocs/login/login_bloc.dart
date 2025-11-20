import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_event.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_state.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteRepository _authRemoteRepository;
  final AuthLocalRepositoty _authLocalRepositoty;
  LoginBloc(this._authRemoteRepository, this._authLocalRepositoty)
    : super(LoginInitialState()) {
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

    on<LoginStatusCheckEvent>((event, emit) {
      try {
        final token = _authLocalRepositoty.getToken(
          LocalStorageConstants.tokenKey,
        );
        if (token.isNotEmpty) {
          emit(LoginStatusSuccessState());
        }
      } catch (e) {
        emit(LoginStatusFailureState());
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        await _authLocalRepositoty.clearAll();
        emit(LogoutSuccessState());
      } catch (e) {
        emit(LogoutFailureState());
      }
    });
  }
}
