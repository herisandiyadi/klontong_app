import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase useCase;
  static const int _pageSize = 10;

  List<ProductEntity> _allProducts = [];
  int _currentPage = 1;
  bool _hasMore = false;
  bool _isLoadingMore = false;

  ProductBloc(this.useCase) : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      if (event.isNextPage) {
        if (_isLoadingMore || !_hasMore) return;
        _isLoadingMore = true;
        emit(
          ProductLoaded(
            _allProducts.take(_currentPage * _pageSize).toList(),
            currentPage: _currentPage,
            hasMore: _hasMore,
            isLoadingMore: true,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        _currentPage++;
        final totalLoaded = _currentPage * _pageSize;
        _hasMore = _allProducts.length > totalLoaded;
        emit(
          ProductLoaded(
            _allProducts.take(totalLoaded).toList(),
            currentPage: _currentPage,
            hasMore: _hasMore,
            isLoadingMore: false,
          ),
        );
        _isLoadingMore = false;
      } else {
        emit(ProductLoading());
        try {
          _allProducts = await useCase.getProducts();
          _currentPage = 1;
          final initialList = _allProducts.take(_pageSize).toList();
          _hasMore = _allProducts.length > _pageSize;
          emit(
            ProductLoaded(
              initialList,
              currentPage: _currentPage,
              hasMore: _hasMore,
              isLoadingMore: false,
            ),
          );
        } catch (e) {
          emit(ProductError(e.toString()));
        }
      }
    });

    on<AddProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await useCase.addProduct(event.product);
        _allProducts = await useCase.getProducts();
        _currentPage = 1;
        final initialList = _allProducts.take(_pageSize).toList();
        _hasMore = _allProducts.length > _pageSize;
        emit(
          ProductLoaded(
            initialList,
            currentPage: _currentPage,
            hasMore: _hasMore,
            isLoadingMore: false,
          ),
        );
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await useCase.deleteProduct(event.id);
        _allProducts = await useCase.getProducts();
        _currentPage = 1;
        final initialList = _allProducts.take(_pageSize).toList();
        _hasMore = _allProducts.length > _pageSize;
        emit(
          ProductLoaded(
            initialList,
            currentPage: _currentPage,
            hasMore: _hasMore,
            isLoadingMore: false,
          ),
        );
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
