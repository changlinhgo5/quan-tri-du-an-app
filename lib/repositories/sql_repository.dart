// import 'dart:convert';
// import 'dart:developer';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:objectid/objectid.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:mp_models/mp_models.dart';
// import '../index.dart';

// import 'package:es_models/es_models.dart' as ESModels;

// class SqfliteRepository {
//   late Database _userDb;
//   String userDbName = 'user_data.db';
//   factory SqfliteRepository() {
//     if (_this == null) _this = SqfliteRepository._getInstance();
//     return _this!;
//   }
//   static SqfliteRepository? _this;
//   SqfliteRepository._getInstance();

//   Future<Database> get database async {
//     if (_userDb != null) return _userDb;
//     _userDb = await initDB();
//     return _userDb;
//   }

//   initDB() async {
//     // print("khoi tao dbbbb");
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, userDbName);
//     print("pathDb: $path");
//     _userDb = await openDatabase(path, version: 1);
//     await _createUserDbTable(_userDb);
//     return _userDb;
//   }

//   Future _createUserDbTable(db) async {
//     await db.execute(createTopicProgressTable);
//     await db.execute(createMyCardDataTable);
//     await db.execute(createCardProgressTableMP);
//     await db.execute(ESModels.createTableCardProgressES);
//     await db.execute(ESModels.createTableMockTest);
//     await db.execute(ESModels.createTableMockTestData);
//   }

//   _checkAndCopyDatabase(String name) async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, name);

//     print("pathxxx: $path");
//     // Only copy if the database doesn't exist
//     if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
//       // Load database from asset and copy
//       print("dbName not found $name documentsDirectory.path: ${documentsDirectory.path}");
//       ByteData data = await rootBundle.load(join('assets', name));
//       List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//       await File(path).writeAsBytes(bytes);
//       print("dbName $name copy successs documentsDirectory.path: ${documentsDirectory.path}");
//     } else {
//       print("dbName found $name documentsDirectory.path: ${documentsDirectory.path}");
//     }
//   }

//   String getIdsQueryTopic(List<dynamic> list) {
//     String sql = '(';
//     int index = 0;
//     for (var q in list) {
//       if (index > 0) {
//         sql += ',';
//       }
//       sql += "'${q.id}'";
//       index++;
//     }
//     sql += ')';
//     return sql;
//   }

//   String getIdsFromList(List<dynamic> list) {
//     String sql = '(';
//     int index = 0;
//     for (var q in list) {
//       if (index > 0) {
//         sql += ',';
//       }
//       sql += "'${q}'";
//       index++;
//     }
//     sql += ')';
//     return sql;
//   }

//   Future updateTopicProgress(TopicProgress t) async {
//     Map<String, dynamic> data = t.toMap();
//     // print("updatetopicprogres in sqlite: ${data}");

//     await _userDb.insert(
//       tableTopicProgress,
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future updateMycardData(
//     MyCardData mc,
//   ) async {
//     Map<String, dynamic> data = mc.toMap(toServer: false);
//     // print("mycarddatta in sqlite: ${data}");

//     await _userDb.insert(
//       tableMyCardData,
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<Map<int, TopicProgress>> getTopicProgressByIds({required List<int> ids, int? parentId}) async {
//     Map<int, TopicProgress> data = {};
//     List<Map> maps = [];
//     String userId = ClientData.user?.id ?? "";

//     maps = await _userDb.query(
//       tableTopicProgress,
//       where: "userId = ?  AND topicId IN ${getIdsFromList(ids)}",
//       whereArgs: [
//         userId,
//       ],
//     );
//     if (maps.isNotEmpty) {
//       for (var item in maps) {
//         TopicProgress tP = TopicProgress.fromMap(item);
//         data.putIfAbsent(tP.topicId, () => tP);
//       }
//     }
//     return data;
//   }

//   Future<Map<int, MyCardData>> getMyCardDataByIds({required List<int> ids, int? parentId}) async {
//     Map<int, MyCardData> data = {};
//     List<Map> maps = [];
//     String userId = ClientData.user?.id ?? "";

//     maps = await _userDb.query(
//       tableMyCardData,
//       where: "userId = ?  AND topicId IN ${getIdsFromList(ids)}",
//       whereArgs: [
//         userId,
//       ],
//     );
//     if (maps.isNotEmpty) {
//       for (var item in maps) {
//         MyCardData mc = MyCardData.fromMap(item as Map<String, dynamic>, fromServer: false);
//         data.putIfAbsent(mc.topicId, () => mc);
//       }
//     }
//     return data;
//   }

//   Future updateMPCardProgress({required CardProgress cardProgress}) async {
//     Map<String, dynamic> data = cardProgress.toMap(saveSqlite: true);
//     print("cardprogressupdateMPPPPPPP $data");
//     await _userDb.insert(
//       tableCardProgressMP,
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future updateESCardProgress({required ESModels.CardProgress cardProgress}) async {
//     Map<String, dynamic> data = cardProgress.toMap(saveSqlite: true);
//     // print("cardprogressupdate $data");
//     await _userDb.insert(
//       ESModels.tableCardProgressES,
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<Map<int, CardProgress>> getMPCardProgressByParentIdOrIds({int? parentId, List<int> ids = const []}) async {
//     Map<int, CardProgress> data = {};
//     String userId = ClientData.user?.id ?? "";
//     List<Map> maps = [];
//     if (parentId != null) {
//       //load card by parentId
//       maps = await _userDb.query(
//         tableCardProgressMP,
//         where: 'userId= ?  and (parentId = ? or cardId in ${getIdsFromList(ids)})',
//         whereArgs: [
//           userId,
//           parentId,
//         ],
//       );
//     } else {
//       if (ids.isNotEmpty) {
//         //load card by ids
//         maps = await _userDb.query(
//           tableCardProgressMP,
//           where: "userId = ?  AND  cardId IN ${getIdsFromList(ids)}",
//           whereArgs: [
//             userId,
//           ],
//         );
//       }
//     }
//     if (maps.isNotEmpty) {
//       for (var item in maps) {
//         CardProgress cp = CardProgress.fromMap(item);
//         data.putIfAbsent(cp.cardId, () => cp);
//       }
//     }
//     return data;
//   }

//   Future<Map<String, ESModels.CardProgress>> getESCardProgressByParentIdOrIds(
//       {int? parentId, List<String> ids = const []}) async {
//     Map<String, ESModels.CardProgress> data = {};
//     String userId = ClientData.user?.id ?? "";
//     List<Map> maps = [];
//     if (parentId != null) {
//       //load card by parentId
//       maps = await _userDb.query(
//         ESModels.tableCardProgressES,
//         where: 'userId= ?  and (parentId = ? or cardId in ${getIdsFromList(ids)})',
//         whereArgs: [
//           userId,
//           parentId,
//         ],
//       );
//     } else {
//       if (ids.isNotEmpty) {
//         //load card by ids
//         maps = await _userDb.query(
//           ESModels.tableCardProgressES,
//           where: "userId = ?  AND  cardId IN ${getIdsFromList(ids)}",
//           whereArgs: [
//             userId,
//           ],
//         );
//       }
//     }
//     if (maps.isNotEmpty) {
//       for (var item in maps) {
//         ESModels.CardProgress cp = ESModels.CardProgress.fromMap(item, fromServer: false);
//         data.putIfAbsent(cp.cardId, () => cp);
//       }
//     }
//     return data;
//   }

//   Future<List<ESModels.MockTest>> loadListTested({List<String> idsTest = const []}) async {
//     List<ESModels.MockTest> results = [];
//     var data;
//     if (idsTest.isEmpty) {
//       data = await _userDb.query(
//         ESModels.ColumnString.tableMockTest,
//         where: "parentId IS NULL",
//         orderBy: "createdAt DESC",
//       );
//     } else {
//       // print(
//       //     " SELECT * FROM ${ColumnString.tableMockTest} WHERE parentId IN ${getIdsFromList(idsTest)} AND createdAt = ( SELECT MAX(createdAt) FROM ${ColumnString.tableMockTest} )");
//       data = await _userDb.rawQuery(
//         "SELECT *,max(createdAt) FROM ${ESModels.ColumnString.tableMockTest} WHERE parentId IN ${getIdsFromList(idsTest)} GROUP BY id;",
//       );
//     }
//     if (data.isNotEmpty) {
//       data.forEach((element) {
//         ESModels.MockTest m = ESModels.MockTest.fromMap(element);
//         results.add(m);
//       });
//     }
//     return results;
//   }

//   Future<List<ESModels.MockTest>> loadTestedByCourseId({String idCourse = ''}) async {
//     List<ESModels.MockTest> results = [];
//     var data;
//     if (idCourse == '') {
//       data = await _userDb.query(
//         ESModels.ColumnString.tableMockTest,
//         where: "courseId IS NULL",
//         orderBy: "createdAt DESC",
//       );
//     } else {
//       // print(
//       //     " SELECT * FROM ${ColumnString.tableMockTest} WHERE parentId IN ${getIdsFromList(idsTest)} AND createdAt = ( SELECT MAX(createdAt) FROM ${ColumnString.tableMockTest} )");
//       data = await _userDb.rawQuery(
//         "SELECT *,max(createdAt) FROM ${ESModels.ColumnString.tableMockTest} WHERE courseId = $idCourse",
//       );
//     }
//     if (data.isNotEmpty) {
//       data.forEach((element) {
//         //print('dataaaaaaaaaaaaaaa $data');
//         if (element['id'] != null) {
//           ESModels.MockTest m = ESModels.MockTest.fromMap(element);
//           results.add(m);
//         }
//       });
//     }
//     return results;
//   }

//   Future<String> insertOrUpdate<T extends ESModels.BaseObject>(
//       {required String table, required T object, bool deleteNote = false}) async {
//     if (deleteNote) {
//       _userDb.delete(table, where: 'id = ?', whereArgs: [object.id]);
//     }
//     if (object.id == null) {
//       // insert
//       final objectId = ObjectId();
//       object.id = objectId.hexString;
//       await _userDb.insert(table, object.toMap());
//       return objectId.hexString;
//     } else {
//       // update
//       await _userDb.update(table, object.toMap(), where: 'id = ?', whereArgs: [object.id]);
//       return object.id!;
//     }
//   }

//   Future<List<CardProgress>> getCardProgressByCardIds({
//     required List<String> cardIds,
//     required String userId,
//     required String parentId,
//   }) async {
//     List<Map> maps = await _userDb.query(
//       ESModels.tableCardProgress,
//       where: 'userId= ?  and (parentId = ? or cardId in ${getIdsFromList(cardIds)})',
//       whereArgs: [
//         userId,
//         parentId,
//       ],
//     );
//     return maps.map((e) => CardProgress.fromMap(e)).toList();
//   }

//   String getIdsInListObject(List<dynamic> list) {
//     String sql = '(';
//     int index = 0;
//     for (var q in list) {
//       if (index > 0) {
//         sql += ',';
//       }
//       sql += "'${q.id}'";
//       index++;
//     }
//     sql += ')';
//     return sql;
//   }

//   Future<ESModels.MockTestData?> loadTestDataForReview({String? testId}) async {
//     if (testId != null) {
//       var data = await _userDb.query(ESModels.ColumnString.tableMockTestData);
//       if (data.isNotEmpty) {
//         return ESModels.MockTestData.fromMap(data.first);
//       } else
//         return null;
//     } else {
//       return null;
//     }
//   }

//   Future<void> saveTestData(ESModels.MockTestData testData) async {
//     var exist = await _userDb.query(
//       ESModels.ColumnString.tableMockTestData,
//       where: 'testId =?',
//       whereArgs: [testData.testId],
//     );
//     if (exist.isEmpty) {
//       var _newId = ObjectId();
//       testData.id = _newId.hexString;
//       await _userDb.insert(ESModels.ColumnString.tableMockTestData, testData.toMap(),
//           conflictAlgorithm: ConflictAlgorithm.replace);
//     } else {
//       try {
//         await _userDb.update(
//           ESModels.ColumnString.tableMockTestData,
//           testData.toMap(),
//           where: 'testId =?',
//           whereArgs: [testData.testId],
//         );
//       } catch (e) {
//         log(e.toString());
//       }
//     }
//   }
// }
