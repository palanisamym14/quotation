// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'package:sqfentity_gen/sqfentity_gen.dart';
// import 'package:sqfentity/sqfentity.dart';
//
// // import 'model/model.dart';
// const SqfEntityTable tableProduct = SqfEntityTable(
//     tableName: 'product',
//     primaryKeyName: 'id',
//     primaryKeyType: PrimaryKeyType.integer_auto_incremental,
//     useSoftDeleting: true,
//     // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
//     modelName:
//         null, // SqfEntity will set it to TableName automatically when the modelName (class name) is null
//     // declare fields
//     fields: [
//       SqfEntityField('name', DbType.text),
//       SqfEntityField('isActive', DbType.bool, defaultValue: true),
//       SqfEntityField('recentlyUsed', DbType.datetimeUtc,
//           defaultValue: 'DateTime.now()'),
//       SqfEntityField('createdDate', DbType.datetimeUtc,
//           defaultValue: 'DateTime.now()'),
//       SqfEntityField('favorite', DbType.bool, defaultValue: false),
//     ]);
//
// // Define the 'tableProduct' constant as SqfEntityTable for the product table
// const tableItems = SqfEntityTable(
//     tableName: 'items',
//     primaryKeyName: 'id',
//     primaryKeyType: PrimaryKeyType.integer_auto_incremental,
//     useSoftDeleting: true,
//     fields: [
//       SqfEntityField(
//         'productId',
//         DbType.text,
//         isNotNull: true,
//       ),
//       SqfEntityField('description', DbType.text),
//       SqfEntityField('price', DbType.real, defaultValue: 0),
//       SqfEntityField('quantity', DbType.real, defaultValue: 0),
//       SqfEntityField('totalPrice', DbType.real, defaultValue: 0),
//       SqfEntityField('sequence', DbType.integer, isNotNull: true),
//       SqfEntityFieldRelationship(
//           parentTable: tableProduct,
//           deleteRule: DeleteRule.CASCADE,
//           defaultValue: 1,
//           formDropDownTextField:
//               'productId' // displayText of dropdownList for category. 'name' => a text field from the category table
//           ),
//       SqfEntityField('datetime', DbType.datetime,
//           defaultValue: 'DateTime.now()'),
//     ]);
//
// const seqIdentity = SqfEntitySequence(
//   sequenceName: 'identity',
//   //maxValue:  10000, /* optional. default is max int (9.223.372.036.854.775.807) */
//   //modelName: 'SQEidentity',
//   /* optional. SqfEntity will set it to sequenceName automatically when the modelName is null*/
//   //cycle : false,    /* optional. default is false; */
//   //minValue = 0;     /* optional. default is 0 */
//   //incrementBy = 1;  /* optional. default is 1 */
//   // startWith = 0;   /* optional. default is 0 */
// );
//
// @SqfEntityBuilder(myDbModel)
// const SqfEntityModel myDbModel = SqfEntityModel(
//     modelName: 'MyDbModel',
//     databaseName: 'quotationORM.db',
//     password:
//         null, // You can set a password if you want to use crypted database (For more information: https://github.com/sqlcipher/sqlcipher)
//     // put defined tables into the tables list.
//     databaseTables: [tableProduct, tableItems],
//     // You can define tables to generate add/edit view forms if you want to use Form Generator property
//     formTables: [tableProduct, tableItems],
//     // put defined sequences into the sequences list.
//     sequences: [seqIdentity],
//     dbVersion: 2,
//     bundledDatabasePath: null //         'assets/sample.db'
//     // This value is optional. When bundledDatabasePath is empty then
//     // EntityBase creats a new database when initializing the database
//     );
