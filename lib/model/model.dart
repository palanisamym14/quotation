// flutter pub run build_runner build --delete-conflicting-outputs

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';

const SqfEntityTable tableCompany = SqfEntityTable(
    tableName: 'company',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "TblCompany",
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

const SqfEntityTable tableQuotation = SqfEntityTable(
    tableName: 'quotation',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "TblQuotation",
    fields: [
      SqfEntityField('productId', DbType.text),
      SqfEntityField('quantity', DbType.text),
      SqfEntityField('price', DbType.text),
      SqfEntityField('totalPrice', DbType.text),
      SqfEntityField('sequenceNo', DbType.integer),
      SqfEntityFieldRelationship(
        parentTable: tableQuotationHeader,
        deleteRule: DeleteRule.CASCADE,
        defaultValue: 1,
      ),
    ]);

const SqfEntityTable tableQuotationHeader = SqfEntityTable(
    tableName: 'quotationHdr',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "TblQuotationHeader",
    fields: [
      SqfEntityField('isPrinted', DbType.bool, defaultValue: false),
      SqfEntityFieldRelationship(
        parentTable: tableCustomerDetails,
        deleteRule: DeleteRule.CASCADE,
        defaultValue: 1,
      ),
      SqfEntityField('createdDate', DbType.datetimeUtc,
          defaultValue: 'DateTime.now()'),
    ]);

const SqfEntityTable tableQuotationSummary = SqfEntityTable(
    tableName: 'quotationSummary',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "TblQuotationSummary",
    fields: [
      SqfEntityFieldRelationship(
        parentTable: tableQuotationHeader,
        deleteRule: DeleteRule.CASCADE,
        defaultValue: 1,
      ),
      SqfEntityField('grandTotal', DbType.real, defaultValue: 1),
      SqfEntityField('discount', DbType.real, defaultValue: 0),
      SqfEntityField('netPay', DbType.real, defaultValue: 0),
      SqfEntityField('wages', DbType.real, defaultValue: 0),
      SqfEntityField('transport', DbType.real, defaultValue: 0),
    ]);

const SqfEntityTable tableCustomerDetails = SqfEntityTable(
    tableName: 'customer',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "TblCustomer",
    fields: [
      SqfEntityField('companyName', DbType.text),
      SqfEntityField('addressLine1', DbType.text, defaultValue: ''),
      SqfEntityField('addressLine2', DbType.text, defaultValue: ''),
      SqfEntityField('mobile', DbType.text, defaultValue: ''),
      SqfEntityField('email', DbType.text, defaultValue: ''),
    ]);

const SqfEntityTable tableProduct = SqfEntityTable(
    tableName: 'product',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "TblProduct",
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('isActive', DbType.bool, defaultValue: true),
      SqfEntityField('recentlyUsed', DbType.datetimeUtc,
          defaultValue: 'DateTime.now()'),
      SqfEntityField('createdDate', DbType.datetimeUtc,
          defaultValue: 'DateTime.now()'),
      SqfEntityField('favorite', DbType.bool, defaultValue: false),
    ]);

const SqfEntityTable tableItems = SqfEntityTable(
    tableName: 'items',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "TblItems",
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

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'DBQuotation',
    databaseName: 'quotation.db',
    password:
        null, // You can set a password if you want to use crypted database (For more information: https://github.com/sqlcipher/sqlcipher)
    // put defined tables into the tables list.
    databaseTables: [
      tableCompany,
      tableCustomerDetails,
      tableProduct,
      tableQuotationHeader,
      tableQuotation,
      tableQuotationSummary,
      tableItems,
    ],
    dbVersion: 1,
    bundledDatabasePath: null //         'assets/sample.db'
    // This value is optional. When bundledDatabasePath is empty then
    // EntityBase creates a new database when initializing the database
    );

/* STEP 3: That's All..
--> Go Terminal Window and run command below
    flutter pub run build_runner build --delete-conflicting-outputs
  Note: After running the command Please check lib/model/model.g.dart
*/
