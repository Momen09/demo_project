// import 'dart:convert';
//
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class CacheApi {
//   CacheApi._privateConstructor();
//
//   static final CacheApi instance = CacheApi._privateConstructor();
//
//   Future<dynamic> getCachedData(String apiUrl) async {
//     Database db = await openDatabase(
//       join(await getDatabasesPath(), 'api_cache_db'),
//     );
//     List<Map<String, dynamic>> maps =
//         await db.query('response', where: 'apiUrl = ?', whereArgs: [apiUrl]);
//
//     if (maps.isNotEmpty) {
//       return jsonDecode(maps.first['responseData']);
//     }
//     return null;
//   }
//
//   Future<dynamic> cacheResponse(dynamic responseData, String apiUrl) async {
//     Database db = await openDatabase(
//       join(await getDatabasesPath(), 'api_cache_db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE responses(apiUrl TEXT PRIMARY KEY, responseData TEXT)',
//         );
//       },
//       version: 1,
//     );
//     String responseDataString = jsonEncode(responseData);
//
//     await db.transaction((txn) async {
//       bool tableExists = await _isTableExists(txn, 'responses');
//       if (!tableExists) {
//         await txn.execute(
//           'CREATE TABLE responses(apiUrl TEXT PRIMARY KEY, responseData TEXT)',
//         );
//       }
//
//       await txn.insert(
//         'responses',
//         {
//           'apiUrl': apiUrl,
//           'responseData': responseDataString,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     });
//   }
//
//   Future<bool> _isTableExists(Transaction txn, String tableName) async {
//     var result = await txn.rawQuery(
//       "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
//     );
//     return result.isNotEmpty;
//   }
// }
