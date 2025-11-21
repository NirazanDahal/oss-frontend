import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/purchase/blocs/update_purchase/update_purchase_event.dart';
import 'package:oss_frontend/features/purchase/blocs/update_purchase/update_purchase_state.dart';
import 'package:oss_frontend/features/purchase/repositories/update_purchase_remote_repository.dart';

class UpdatePurchaseBloc
    extends Bloc<UpdatePurchaseEvent, UpdatePurchaseState> {
  final UpdatePurchaseRemoteRepository _repository;

  UpdatePurchaseBloc(this._repository) : super(UpdatePurchaseInitialState()) {
    on<UpdatePurchaseSubmittedEvent>(_onUpdatePurchaseSubmitted);
    on<ResetUpdatePurchaseStateEvent>(_onResetState);
  }

  Future<void> _onUpdatePurchaseSubmitted(
    UpdatePurchaseSubmittedEvent event,
    Emitter<UpdatePurchaseState> emit,
  ) async {
    emit(UpdatePurchaseLoadingState());
    try {
      final response = await _repository.updatePurchase(
        event.purchaseId,
        event.request,
      );
      emit(UpdatePurchaseSuccessState(response));
    } on CreateException catch (e) {
      emit(UpdatePurchaseFailureState(e.error));
    } catch (e) {
      emit(
        UpdatePurchaseFailureState(
          ErrorResponseModel(
            success: false,
            error: ResponseConstants.updatePurchaseFailureMessage,
          ),
        ),
      );
    }
  }

  void _onResetState(
    ResetUpdatePurchaseStateEvent event,
    Emitter<UpdatePurchaseState> emit,
  ) {
    emit(UpdatePurchaseInitialState());
  }
}
