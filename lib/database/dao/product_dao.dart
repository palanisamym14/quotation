// dao/product_dao.dart

import 'package:floor/floor.dart';
import 'package:quotation/database/entity/product.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM Product')
  Future<List<ProductEntity>> findAllProducts();

  @Query('SELECT * FROM Product WHERE id = :id')
  Future<ProductEntity?> findProductById(int id);

  @insert
  Future<void> insertProduct(ProductEntity person);
}