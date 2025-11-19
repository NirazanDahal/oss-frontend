// get_customer_bloc.dart
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_state.dart';
import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';
import 'package:oss_frontend/features/costomer/repositories/get_customer_remote_repository.dart';

class GetCustomerBloc extends Bloc<GetCustomerEvent, GetCustomerState> {
  final GetCustomerRemoteRepository _getCustomerRemoteRepository;

  List<CustomerData> allCustomers = [];
  String? lastSearch = '';
  int currentPage = 1;
  int totalPages = 1;
  final int limit = 10;
  bool isLoadingMore = false;

  GetCustomerBloc(this._getCustomerRemoteRepository)
    : super(GetCustomerInitialState()) {
    on<GetCustomerSubmittedEvent>((event, emit) async {
      allCustomers.clear();
      currentPage = 1;
      lastSearch = event.search?.trim();

      emit(GetCustomerLoadingState());

      try {
        final response = await _getCustomerRemoteRepository.getCustomer(
          lastSearch,
          currentPage,
          limit,
        );

        allCustomers = response.customerData;
        totalPages = response.totalPages;

        emit(GetCustomerSuccessState(allCustomers));
      } on CreateException catch (e) {
        emit(GetCustomerFailureState(e.error));
      } catch (e) {
        log(e.toString());
        emit(
          GetCustomerFailureState(
            ErrorResponseModel(
              success: false,
              error: ResponseConstants.getCustomerFailureMessage,
            ),
          ),
        );
      }
    });
    on<GetCustomerLoadMoreEvent>((event, emit) async {
      if (isLoadingMore || currentPage >= totalPages) return;

      isLoadingMore = true;
      emit(GetCustomerMoreLoadingState(allCustomers));

      currentPage++;

      try {
        final response = await _getCustomerRemoteRepository.getCustomer(
          lastSearch,
          currentPage,
          limit,
        );

        allCustomers.addAll(response.customerData);
        totalPages = response.totalPages;

        emit(GetCustomerSuccessState(allCustomers));
      } catch (e) {
        currentPage--;
      } finally {
        isLoadingMore = false;
      }
    });
  }
}
