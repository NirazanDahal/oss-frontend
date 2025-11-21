part of 'get_product_bloc.dart';

abstract class GetProductEvent {}

class GetProductSubmittedEvent extends GetProductEvent {
  final String? search;

  GetProductSubmittedEvent({this.search});
}

class GetProductLoadMoreEvent extends GetProductEvent {}
