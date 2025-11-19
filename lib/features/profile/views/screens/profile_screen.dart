import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/profile/blocs/profile/profile_bloc.dart';
import 'package:oss_frontend/features/profile/blocs/profile/profile_event.dart';
import 'package:oss_frontend/features/profile/blocs/profile/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileSubmittedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.getCustomerScreen);
            },
            icon: Icon(Icons.person_add),
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // if (state is GetProfileLoadingState) {
          //   SnackUtils.showInfo(ResponseConstants.getProfileLoadingMessage);
          // }
          // if (state is GetProfileSuccessState) {
          //   SnackUtils.showSuccess(ResponseConstants.getProfileSuccessMessage);
          // }
          // if (state is GetProfileFailureState) {
          //   SnackUtils.showError(state.error.error);
          // }
        },
        builder: (context, state) {
          if (state is GetProfileSuccessState) {
            return Center(
              child: Column(
                children: [
                  Text(state.profileResponse.userProfile.id),
                  Text(state.profileResponse.userProfile.name),
                  Text(state.profileResponse.userProfile.email),
                  Text(state.profileResponse.userProfile.role),
                  Text(
                    '${state.profileResponse.userProfile.createdAt.year.toString()}/${state.profileResponse.userProfile.createdAt.month.toString()}/${state.profileResponse.userProfile.createdAt.day.toString()}',
                  ),
                  Text(state.profileResponse.userProfile.updatedAt.toString()),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(ResponseConstants.getProfileFailureMessage),
            );
          }
        },
      ),
    );
  }
}
