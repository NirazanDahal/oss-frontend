import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_state.dart';
import 'package:oss_frontend/features/costomer/repositories/add_customer_remote_repository.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  final AddCustomerRemoteRepository _addCustomerRemoteRepository;
  AddCustomerBloc(this._addCustomerRemoteRepository)
    : super(AddCustomerInitialState()) {
    on<AddCustomerSubmittedEvent>((event, emit) async {
      emit(AddCustomerLoadingState());
      try {
        final response = await _addCustomerRemoteRepository.addCustomer(
          event.name,
          event.phone,
          event.address,
        );
        emit(AddCustomerSuccessState(response));
      } on CreateException catch (e) {
        emit(AddCustomerFailureState(e.error));
      } catch (e) {
        emit(
          AddCustomerFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.addCustomerFailureMessage,
            ),
          ),
        );
      }
    });

    on<ResetAddCustomerStateEvent>((event, emit) {
      emit(AddCustomerInitialState());
    });
  }
}
