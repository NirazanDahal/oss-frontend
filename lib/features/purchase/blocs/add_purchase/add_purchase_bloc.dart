import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/purchase/blocs/add_purchase/add_purchase_event.dart';
import 'package:oss_frontend/features/purchase/blocs/add_purchase/add_purchase_state.dart';
import 'package:oss_frontend/features/purchase/repositories/add_purchase_remote_repository.dart';

class AddPurchaseBloc extends Bloc<AddPurchaseEvent, AddPurchaseState> {
  final AddPurchaseRemoteRepository _addPurchaseRemoteRepository;

  AddPurchaseBloc(this._addPurchaseRemoteRepository)
    : super(AddPurchaseInitialState()) {
    on<AddPurchaseSubmittedEvent>((event, emit) async {
      emit(AddPurchaseLoadingState());
      try {
        final response = await _addPurchaseRemoteRepository.addPurchase(
          event.request,
        );
        emit(AddPurchaseSuccessState(response));
      } catch (e) {
        emit(
          AddPurchaseFailureState(
            ErrorResponseModel(
              success: false,
              error: e.toString().replaceAll('Exception: ', ''),
            ),
          ),
        );
      }
    });

    on<ResetAddPurchaseStateEvent>((event, emit) {
      emit(AddPurchaseInitialState());
    });
  }
}
