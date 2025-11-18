// lib/features/customer/blocs/customer_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/features/customer/models/req/customer_request_model.dart';
import 'package:oss_frontend/features/customer/usecases/create_customer_usecase.dart';
import 'package:oss_frontend/features/customer/usecases/get_customer_usecase.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CreateCustomerUseCase _createCustomer;
  final GetCustomersUseCase _getCustomers;

  CustomerBloc(this._createCustomer, this._getCustomers) : super(CustomerInitial()) {
    on<LoadCustomers>(_onLoadCustomers);
    on<SearchCustomers>(_onSearchCustomers);
    on<AddCustomer>(_onAddCustomer);
  }

  Future<void> _onLoadCustomers(LoadCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final response = await _getCustomers(page: event.page, limit: event.limit);
      if (response.success) {
        emit(CustomerLoaded(
          customers: response.data,
          hasReachedMax: response.page >= response.totalPages,
          currentPage: response.page,
          totalPages: response.totalPages,
        ));
      } else {
        emit(CustomerError(response.error ?? 'Failed to load customers'));
      }
    } catch (e) {
      emit(CustomerError(e.toString()));
    }
  }

  Future<void> _onSearchCustomers(SearchCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final response = await _getCustomers(search: event.query, page: 1, limit: event.limit);
      if (response.success) {
        emit(CustomerLoaded(
          customers: response.data,
          hasReachedMax: response.page >= response.totalPages,
          currentPage: 1,
          totalPages: response.totalPages,
          currentQuery: event.query,
        ));
      } else {
        emit(CustomerError(response.error ?? 'Search failed'));
      }
    } catch (e) {
      emit(CustomerError(e.toString()));
    }
  }

  Future<void> _onAddCustomer(AddCustomer event, Emitter<CustomerState> emit) async {
    try {
      final response = await _createCustomer(
        name: event.name,
        phone: event.phone,
        address: event.address,
      );

      if (response.success) {
        // Reload first page after adding
        add( LoadCustomers(page: 1, limit: 10));
      } else {
        emit(CustomerError(response.error ?? 'Failed to add customer'));
      }
    } catch (e) {
      emit(CustomerError(e.toString()));
    }
  }
}