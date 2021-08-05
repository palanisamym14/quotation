import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import '../src/utils/helper.dart';
// import 'view.list.dart';

part 'model.g.dart';

// part 'model.g.view.dart';
const SqfEntityTable tableCompany = SqfEntityTable(
    tableName: 'company',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
    modelName:
        null, // SqfEntity will set it to TableName automatically when the modelName (class name) is null
    // declare fields
    fields: [
      SqfEntityField('companyName', DbType.text),
      SqfEntityField('addressLine1', DbType.text, defaultValue: ''),
      SqfEntityField('addressLine2', DbType.text, defaultValue: ''),
      SqfEntityField('mobile', DbType.text, defaultValue: ''),
      SqfEntityField('email', DbType.text, defaultValue: ''),
      SqfEntityField('currency', DbType.text),
      SqfEntityField('logoUrl', DbType.text),
      SqfEntityField('updated', DbType.datetimeUtc,
          defaultValue: 'DateTime.now()'),
      SqfEntityField('createdDate', DbType.datetimeUtc,
          defaultValue: 'DateTime.now()'),
    ]);

const SqfEntityTable tableProduct = SqfEntityTable(
    tableName: 'product',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
    modelName:
        null, // SqfEntity will set it to TableName automatically when the modelName (class name) is null
    // declare fields
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('isActive', DbType.bool, defaultValue: true),
      SqfEntityField('recentlyUsed', DbType.datetimeUtc,
          defaultValue: 'DateTime.now()'),
      SqfEntityField('createdDate', DbType.datetimeUtc,
          defaultValue: 'DateTime.now()'),
      SqfEntityField('favorite', DbType.bool, defaultValue: false),
    ]);

// Define the 'tableProduct' constant as SqfEntityTable for the product table
const tableItems = SqfEntityTable(
    tableName: 'items',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('description', DbType.text),
      SqfEntityField('price', DbType.real, defaultValue: 0),
      SqfEntityField('quantity', DbType.real, defaultValue: 0),
      SqfEntityField('totalPrice', DbType.real, defaultValue: 0),
      SqfEntityField('sequence', DbType.integer, isNotNull: true),
      SqfEntityFieldRelationship(
        parentTable: tableProduct,
        deleteRule: DeleteRule.CASCADE,
        defaultValue: 1,
      ),
      SqfEntityField('datetime', DbType.datetime,
          defaultValue: 'DateTime.now()'),
    ]);

// Define the 'identity' constant as SqfEntitySequence.
const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
  //maxValue:  10000, /* optional. default is max int (9.223.372.036.854.775.807) */
  //modelName: 'SQEidentity',
  /* optional. SqfEntity will set it to sequenceName automatically when the modelName is null*/
  //cycle : false,    /* optional. default is false; */
  //minValue = 0;     /* optional. default is 0 */
  //incrementBy = 1;  /* optional. default is 1 */
  // startWith = 0;   /* optional. default is 0 */
);

// STEP 2: Create your Database Model constant instanced from SqfEntityModel
// Note: SqfEntity provides support for the use of multiple databases.
// So you can create many Database Models and use them in the application.
@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel',
    databaseName: 'sampleORM_v2.0.0+7.db',
    password:
        null, // You can set a password if you want to use crypted database (For more information: https://github.com/sqlcipher/sqlcipher)
    // put defined tables into the tables list.
    databaseTables: [tableProduct, tableItems, tableCompany],
    sequences: [seqIdentity],
    dbVersion: 2,
    bundledDatabasePath: null //         'assets/sample.db'
    // This value is optional. When bundledDatabasePath is empty then
    // EntityBase creats a new database when initializing the database
    );

/* STEP 3: That's All..
--> Go Terminal Window and run command below
    flutter pub run build_runner build --delete-conflicting-outputs
  Note: After running the command Please check lib/model/model.g.dart and lib/model/model.g.view.dart (If formTables parameter is defined in the model)
  Enjoy.. Huseyin TOKPINAR
*/
