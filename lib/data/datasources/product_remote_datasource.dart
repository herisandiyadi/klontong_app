import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  String get baseUrl {
    final id = dotenv.env['BASE_ID'] ?? '';
    return 'https://crudcrud.com/api/$id/product';
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    final response = await dio.post(baseUrl, data: product.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ProductModel.fromJson(response.data);
    } else {
      throw Exception('Failed to add product');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final url = '$baseUrl/$id';
    final response = await dio.delete(url);
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }
}
