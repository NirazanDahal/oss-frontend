import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/profile/blocs/profile/profile_event.dart';
import 'package:oss_frontend/features/profile/blocs/profile/profile_state.dart';
import 'package:oss_frontend/features/profile/repositories/profile_remote_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRemoteRepository _profileRepository;
  ProfileBloc(this._profileRepository) : super(GetProfileInitialState()) {
    on<GetProfileSubmittedEvent>((event, emit) async {
      emit(GetProfileLoadingState());
      try {
        final response = await _profileRepository.getProfile();
        emit(GetProfileSuccessState(response));
      } on CreateException catch (e) {
        emit(GetProfileFailureState(e.error));
      } catch (e) {
        emit(
          GetProfileFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.getProfileFailureMessage,
            ),
          ),
        );
      }
    });
  }
}
