import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/product_entity.dart';

class CartLocalDataSource {
  static const String _tableName = 'cart';
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            categoryId INTEGER,
            categoryName TEXT,
            sku TEXT,
            name TEXT,
            description TEXT,
            weight INTEGER,
            width INTEGER,
            length INTEGER,
            height INTEGER,
            image TEXT,
            price INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertCart(ProductEntity product) async {
    final db = await database;
    await db.insert(_tableName, {
      'id': product.id,
      'categoryId': product.categoryId,
      'categoryName': product.categoryName,
      'sku': product.sku,
      'name': product.name,
      'description': product.description,
      'weight': product.weight,
      'width': product.width,
      'length': product.length,
      'height': product.height,
      'image': product.image,
      'price': product.price,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCart(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ProductEntity>> getCartList() async {
    final db = await database;
    final result = await db.query(_tableName);
    return result
        .map(
          (e) => ProductEntity(
            id: e['id'] as String,
            categoryId: e['categoryId'] as int,
            categoryName: e['categoryName'] as String,
            sku: e['sku'] as String,
            name: e['name'] as String,
            description: e['description'] as String,
            weight: e['weight'] as int,
            width: e['width'] as int,
            length: e['length'] as int,
            height: e['height'] as int,
            image: e['image'] as String,
            price: e['price'] as int,
          ),
        )
        .toList();
  }
}
