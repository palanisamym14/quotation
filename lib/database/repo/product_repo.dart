import 'package:floor/floor.dart';
import 'package:quotation/database.dart';
import 'package:quotation/database/dao/product_dao.dart';
import 'package:quotation/database/entity/product.dart';

class ProductRepo {
  Future<ProductDao> getProductDao() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.productDao;
  }

  Future<void> insert() async {
    final person = ProductEntity(name: 'Frank');
    final personDao = await getProductDao();
    await personDao.insertProduct(person);
  }

  Future<List<ProductEntity>> find() async {
    final personDao = await getProductDao();
    return await personDao.findAllProducts();
  }

  Future<ProductEntity?> findById(id) async {
    final personDao = await getProductDao();
    return await personDao.findProductById(id);
  }
}
