import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/product/models/res/update_product_response_model.dart';
import 'package:oss_frontend/features/product/repositories/update_product_remote_repository.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final UpdateProductRemoteRepository _updateProductRemoteRepository;

  UpdateProductBloc(this._updateProductRemoteRepository)
      : super(UpdateProductInitialState()) {
    on<UpdateProductSubmittedEvent>((event, emit) async {
      emit(UpdateProductLoadingState());
      try {
        final response = await _updateProductRemoteRepository.updateProduct(
          event.productId,
          event.name,
          event.batchNo,
          event.quantity,
          event.purchasePrice,
          event.sellingPrice,
        );
        emit(UpdateProductSuccessState(response));
      } on UpdateException catch (e) {
        emit(UpdateProductFailureState(e.error));
      } catch (e) {
        emit(
          UpdateProductFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.updateProductFailureMessage,
            ),
          ),
        );
      }
    });

    on<ResetUpdateProductStateEvent>((event, emit) {
      emit(UpdateProductInitialState());
    });
  }
}
