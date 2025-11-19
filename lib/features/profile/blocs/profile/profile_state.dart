import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/profile/models/res/profile_response_model.dart';

abstract class ProfileState {}

class GetProfileInitialState extends ProfileState {}

class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {
  final ProfileResponseModel profileResponse;
  GetProfileSuccessState(this.profileResponse);
}

class GetProfileFailureState extends ProfileState {
  final ErrorResponseModel error;
  GetProfileFailureState(this.error);
}
