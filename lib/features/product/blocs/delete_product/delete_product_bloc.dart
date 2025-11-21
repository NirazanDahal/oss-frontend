import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/product/repositories/delete_product_remote_repository.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  final DeleteProductRemoteRepository _deleteProductRemoteRepository;

  DeleteProductBloc(this._deleteProductRemoteRepository)
      : super(DeleteProductInitialState()) {
    on<DeleteProductSubmittedEvent>((event, emit) async {
      emit(DeleteProductLoadingState());
      try {
        await _deleteProductRemoteRepository.deleteProduct(event.productId);
        emit(DeleteProductSuccessState());
      } on DeleteException catch (e) {
        emit(DeleteProductFailureState(e.error));
      } catch (e) {
        emit(
          DeleteProductFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.deleteProductFailureMessage,
            ),
          ),
        );
      }
    });

    on<ResetDeleteProductStateEvent>((event, emit) {
      emit(DeleteProductInitialState());
    });
  }
}
