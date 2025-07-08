import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:klontong_app/domain/entities/product_entity.dart';
import 'package:klontong_app/domain/repositories/product_repository.dart';
import 'package:klontong_app/domain/usecases/product_usecase.dart';

import 'product_usecase_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late ProductUseCase usecase;
  late MockProductRepository mockRepo;

  setUp(() {
    mockRepo = MockProductRepository();
    usecase = ProductUseCase(mockRepo);
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

  test('should get products from repository', () async {
    when(mockRepo.getProducts()).thenAnswer((_) async => [product]);
    final result = await usecase.getProducts();
    expect(result, [product]);
    verify(mockRepo.getProducts());
  });

  test('should add product to repository', () async {
    when(mockRepo.addProduct(product)).thenAnswer((_) async => product);
    final result = await usecase.addProduct(product);
    expect(result, product);
    verify(mockRepo.addProduct(product));
  });

  test('should delete product from repository', () async {
    when(mockRepo.deleteProduct('1')).thenAnswer((_) async => null);
    await usecase.deleteProduct('1');
    verify(mockRepo.deleteProduct('1'));
  });
}
