import 'package:floor/floor.dart';

@Entity(tableName: "product")
class ProductEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String name;
  ProductEntity({required this.name});
}