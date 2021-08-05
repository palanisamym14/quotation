// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'database/dao/product_dao.dart';
import 'database/entity/product.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ProductEntity])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
}