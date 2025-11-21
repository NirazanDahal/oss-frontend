import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';
import 'package:oss_frontend/features/product/repositories/get_product_remote_repository.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final GetProductRemoteRepository _getProductRemoteRepository;

  List<ProductData> allProducts = [];
  String? lastSearch = '';
  int currentPage = 1;
  int totalPages = 1;
  bool isLoadingMore = false;

  GetProductBloc(this._getProductRemoteRepository)
      : super(GetProductInitialState()) {
    on<GetProductSubmittedEvent>((event, emit) async {
      allProducts.clear();
      currentPage = 1;
      lastSearch = event.search?.trim();

      emit(GetProductLoadingState());

      try {
        final response = await _getProductRemoteRepository.getProducts(
          search: lastSearch,
          page: currentPage,
        );

        allProducts = response.products;
        totalPages = response.totalPages;

        emit(GetProductSuccessState(allProducts));
      } on FetchException catch (e) {
        emit(GetProductFailureState(e.error));
      } catch (e) {
        log(e.toString());
        emit(
          GetProductFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.getProductFailureMessage,
            ),
          ),
        );
      }
    });

    on<GetProductLoadMoreEvent>((event, emit) async {
      if (isLoadingMore || currentPage >= totalPages) return;

      isLoadingMore = true;
      emit(GetProductMoreLoadingState(allProducts));

      currentPage++;

      try {
        final response = await _getProductRemoteRepository.getProducts(
          search: lastSearch,
          page: currentPage,
        );

        allProducts.addAll(response.products);
        totalPages = response.totalPages;

        emit(GetProductSuccessState(allProducts));
      } catch (e) {
        currentPage--;
      } finally {
        isLoadingMore = false;
      }
    });
  }
}
