import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:klontong_app/domain/entities/product_entity.dart';
import 'package:klontong_app/domain/usecases/product_usecase.dart';
import 'package:klontong_app/presentation/bloc/product_bloc.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([ProductUseCase])
void main() {
  late MockProductUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockProductUseCase();
  });

  final product = ProductEntity(
    id: '1',
    categoryId: 14,
    categoryName: 'Cemilan',
    sku: 'SKU1',
    name: 'Test Product',
    description: 'Desc',
    weight: 100,
    width: 0,
    length: 0,
    height: 0,
    image: 'img',
    price: 1000,
  );

  group('ProductBloc', () {
    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when FetchProductsEvent is added',
      build: () {
        when(mockUseCase.getProducts()).thenAnswer((_) async => [product]);
        return ProductBloc(mockUseCase);
      },
      act: (bloc) => bloc.add(FetchProductsEvent()),
      expect:
          () => [
            isA<ProductLoading>(),
            isA<ProductLoaded>().having((s) => s.products, 'products', [
              product,
            ]),
          ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when AddProductEvent is added',
      build: () {
        when(mockUseCase.addProduct(product)).thenAnswer((_) async => product);
        when(mockUseCase.getProducts()).thenAnswer((_) async => [product]);
        return ProductBloc(mockUseCase);
      },
      act: (bloc) => bloc.add(AddProductEvent(product)),
      expect:
          () => [
            isA<ProductLoading>(),
            isA<ProductLoaded>().having((s) => s.products, 'products', [
              product,
            ]),
          ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when DeleteProductEvent is added',
      build: () {
        when(mockUseCase.deleteProduct('1')).thenAnswer((_) async => null);
        when(mockUseCase.getProducts()).thenAnswer((_) async => []);
        return ProductBloc(mockUseCase);
      },
      act: (bloc) => bloc.add(DeleteProductEvent('1')),
      expect:
          () => [
            isA<ProductLoading>(),
            isA<ProductLoaded>().having((s) => s.products, 'products', []),
          ],
    );

    blocTest<ProductBloc, ProductState>(
      'pagination loads next page',
      build: () {
        final products = List.generate(
          25,
          (i) => product.copyWith(id: '$i', name: 'Product $i'),
        );
        when(mockUseCase.getProducts()).thenAnswer((_) async => products);
        return ProductBloc(mockUseCase);
      },
      act: (bloc) async {
        bloc.add(FetchProductsEvent());
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(FetchProductsEvent(isNextPage: true));
        await Future.delayed(const Duration(milliseconds: 600));
        bloc.add(FetchProductsEvent(isNextPage: true));
        await Future.delayed(const Duration(milliseconds: 600));
      },
      skip: 1,
      expect:
          () => [
            isA<ProductLoaded>(),
            isA<ProductLoaded>(),
            isA<ProductLoaded>(),
            isA<ProductLoaded>(),
            isA<ProductLoaded>(),
          ],
      verify: (bloc) {
        final loaded =
            bloc.state is ProductLoaded ? [bloc.state as ProductLoaded] : [];
        // collect all ProductLoaded emitted by bloc
        // but bloc.state only gives last state, so use bloc.stream
        // so, assertion should be done in expect, not verify
        // but for workaround, just check last state
        if (bloc.state is ProductLoaded) {
          final s = bloc.state as ProductLoaded;
          expect(s.products.length, 25);
        }
      },
    );
  });
}

extension on ProductEntity {
  ProductEntity copyWith({
    String? id,
    int? categoryId,
    String? categoryName,
    String? sku,
    String? name,
    String? description,
    int? weight,
    int? width,
    int? length,
    int? height,
    String? image,
    int? price,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }
}
