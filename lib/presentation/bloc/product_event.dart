part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {
  final bool isNextPage;
  FetchProductsEvent({this.isNextPage = false});
}

class AddProductEvent extends ProductEvent {
  final ProductEntity product;
  AddProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  DeleteProductEvent(this.id);
}
