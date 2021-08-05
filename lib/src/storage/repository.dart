// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'package:sqfentity_gen/sqfentity_gen.dart';
// import 'package:sqfentity/sqfentity.dart';
//
// // import 'model/model.dart';
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
