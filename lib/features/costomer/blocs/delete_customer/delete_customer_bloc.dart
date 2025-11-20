import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/delete_customer/delete_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/delete_customer/delete_customer_state.dart';
import 'package:oss_frontend/features/costomer/repositories/delete_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/services/delete_customer_api_service.dart';

class DeleteCustomerBloc
    extends Bloc<DeleteCustomerEvent, DeleteCustomerState> {
  final DeleteCustomerRemoteRepository _deleteCustomerRemoteRepository;
  DeleteCustomerBloc(this._deleteCustomerRemoteRepository)
    : super(DeleteCustomerInitialState()) {
    on<DeleteCustomerSubmittedEvent>((event, emit) async {
      emit(DeleteCustomerLoadingState());
      try {
        await _deleteCustomerRemoteRepository.deleteCustomer(event.id);
        emit(DeleteCustomerSuccessState());
      } on CreateException catch (e) {
        emit(DeleteCustomerFailureState(e.error));
      } catch (e) {
        emit(
          DeleteCustomerFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.deleteCustomerFailureMessage,
            ),
          ),
        );
      }
    });
  }
}
