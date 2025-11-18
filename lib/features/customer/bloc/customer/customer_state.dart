part of 'customer_bloc.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<Customer> customers;
  final bool hasReachedMax;
  final int currentPage;
  final int totalPages;
  final String? currentQuery;

  CustomerLoaded({
    required this.customers,
    required this.hasReachedMax,
    required this.currentPage,
    required this.totalPages,
    this.currentQuery,
  });

  CustomerLoaded copyWith({
    List<Customer>? customers,
    bool? hasReachedMax,
    int? currentPage,
    int? totalPages,
    String? currentQuery,
  }) {
    return CustomerLoaded(
      customers: customers ?? this.customers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      currentQuery: currentQuery ?? this.currentQuery,
    );
  }
}

class CustomerError extends CustomerState {
  final String message;
  CustomerError(this.message);
}