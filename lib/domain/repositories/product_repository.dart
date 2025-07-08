import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
  Future<ProductEntity> addProduct(ProductEntity product);
  Future<void> deleteProduct(String id);
}
