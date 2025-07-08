part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  ProductLoaded(
    this.products, {
    this.currentPage = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
  });
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
