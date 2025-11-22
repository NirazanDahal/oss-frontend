import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/sales/blocs/add_sale/add_sale_event.dart';
import 'package:oss_frontend/features/sales/blocs/add_sale/add_sale_state.dart';
import 'package:oss_frontend/features/sales/repositories/add_sale_remote_repository.dart';

class AddSaleBloc extends Bloc<AddSaleEvent, AddSaleState> {
  final AddSaleRemoteRepository _addSaleRemoteRepository;

  AddSaleBloc(this._addSaleRemoteRepository)
      : super(AddSaleInitialState()) {
    on<AddSaleSubmittedEvent>((event, emit) async {
      emit(AddSaleLoadingState());
      try {
        final response = await _addSaleRemoteRepository.addSale(
          event.request,
        );
        emit(AddSaleSuccessState(response));
      } catch (e) {
        emit(
          AddSaleFailureState(
            ErrorResponseModel(
              success: false,
              error: e.toString().replaceAll('Exception: ', ''),
            ),
          ),
        );
      }
    });

    on<ResetAddSaleStateEvent>((event, emit) {
      emit(AddSaleInitialState());
    });
  }
}
