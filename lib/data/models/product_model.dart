import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required String id,
    required int categoryId,
    required String categoryName,
    required String sku,
    required String name,
    required String description,
    required int weight,
    required int width,
    required int length,
    required int height,
    required String image,
    required int price,
  }) : super(
         id: id,
         categoryId: categoryId,
         categoryName: categoryName,
         sku: sku,
         name: name,
         description: description,
         weight: weight,
         width: width,
         length: length,
         height: height,
         image: image,
         price: price,
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      categoryId: json['CategoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      sku: json['sku'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      weight: json['weight'] ?? 0,
      width: json['width'] ?? 0,
      length: json['length'] ?? 0,
      height: json['height'] ?? 0,
      image: json['image'] ?? '',
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CategoryId': categoryId,
      'categoryName': categoryName,
      'sku': sku,
      'name': name,
      'description': description,
      'weight': weight,
      'width': width,
      'length': length,
      'height': height,
      'image': image,
      'price': price,
    };
  }
}
