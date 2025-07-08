import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProducts() async {
    final models = await remoteDataSource.getProducts();
    return models;
  }

  @override
  Future<ProductEntity> addProduct(ProductEntity product) async {
    final model = ProductModel(
      id: product.id,
      categoryId: product.categoryId,
      categoryName: product.categoryName,
      sku: product.sku,
      name: product.name,
      description: product.description,
      weight: product.weight,
      width: product.width,
      length: product.length,
      height: product.height,
      image: product.image,
      price: product.price,
    );
    final result = await remoteDataSource.addProduct(model);
    return result;
  }

  @override
  Future<void> deleteProduct(String id) async {
    await remoteDataSource.deleteProduct(id);
  }
}
