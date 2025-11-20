import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/update_customer/update_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/update_customer/update_customer_state.dart';
import 'package:oss_frontend/features/costomer/repositories/update_customer_remote_repository.dart';

class UpdateCustomerBloc
    extends Bloc<UpdateCustomerEvent, UpdateCustomerState> {
  final UpdateCustomerRemoteRepository _updateCustomerRepository;
  UpdateCustomerBloc(this._updateCustomerRepository)
    : super(UpdateCustomerInitialState()) {
    on<UpdateCustomerSubmittedEvent>((event, emit) async {
      emit(UpdateCustomerLoadingState());
      try {
        final response = await _updateCustomerRepository.updateCustomer(
          event.id,
          event.name,
          event.phone,
          event.address,
        );
        emit(UpdateCustomerSuccessState(response.customerData));
      } on CreateException catch (e) {
        emit(UpdateCustomerFailureState(e.error));
      } catch (e) {
        emit(
          UpdateCustomerFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.updateCustomerFailureMessage,
            ),
          ),
        );
      }
    });
  }
}
