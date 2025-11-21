import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';
import 'package:oss_frontend/features/product/repositories/add_product_remote_repository.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductRemoteRepository _addProductRemoteRepository;
  
  AddProductBloc(this._addProductRemoteRepository)
      : super(AddProductInitialState()) {
    on<AddProductSubmittedEvent>((event, emit) async {
      emit(AddProductLoadingState());
      try {
        final response = await _addProductRemoteRepository.addProduct(
          event.name,
          event.batchNo,
          event.quantity,
          event.purchasePrice,
          event.sellingPrice,
        );
        emit(AddProductSuccessState(response));
      } on CreateException catch (e) {
        emit(AddProductFailureState(e.error));
      } catch (e) {
        emit(
          AddProductFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.addProductFailureMessage,
            ),
          ),
        );
      }
    });

    on<ResetAddProductStateEvent>((event, emit) {
      emit(AddProductInitialState());
    });
  }
}
