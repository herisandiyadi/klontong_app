import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class ProductUseCase {
  final ProductRepository repository;

  ProductUseCase(this.repository);

  Future<List<ProductEntity>> getProducts() {
    return repository.getProducts();
  }

  Future<ProductEntity> addProduct(ProductEntity product) {
    return repository.addProduct(product);
  }

  Future<void> deleteProduct(String id) {
    return repository.deleteProduct(id);
  }
}
