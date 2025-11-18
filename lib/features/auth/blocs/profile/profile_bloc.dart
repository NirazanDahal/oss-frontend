import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/features/auth/usecases/profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileBloc(this._getProfileUseCase) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final response = await _getProfileUseCase();
      if (response.success && response.user != null) {
        emit(ProfileLoaded(response.user!));
      } else {
        emit(ProfileError(response.error ?? 'Failed to load profile'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}