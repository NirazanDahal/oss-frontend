part of 'customer_bloc.dart';

abstract class CustomerEvent {}

class LoadCustomers extends CustomerEvent {
  final int page;
  final int limit;
   LoadCustomers({this.page = 1, this.limit = 10});
}

class SearchCustomers extends CustomerEvent {
  final String query;
  final int limit;
   SearchCustomers(this.query, {this.limit = 10});
}

class AddCustomer extends CustomerEvent {
  final String name;
  final String phone;
  final String address;
   AddCustomer(this.name, this.phone, this.address);
}