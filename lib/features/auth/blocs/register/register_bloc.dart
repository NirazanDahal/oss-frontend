import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/di/injection.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_event.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_state.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState> {
  final AuthRemoteRepository _authRemoteRepository ;

  RegisterBloc(this._authRemoteRepository):super(RegisterInitialState()){
    on<RegisterSubmittedEvent>((event,emit)async{
      emit(RegisterLoadingState());
      try{
        final response=await _authRemoteRepository.register(event.name, event.email, event.password);
        emit(RegisterSuccessState(response));
      }on CreateException catch (e){
        emit(RegisterFailureState(e.error));
      }catch(e){
        emit(RegisterFailureState(CreateErrorResponse(success: false,error: 'Error registering user.')));
      }
    });

  }


}