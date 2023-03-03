import 'package:path_provider/path_provider.dart';
import 'package:save_task/model_class/model_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DatabaseService {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'TaskSave.db');
    var db = openDatabase(path, version: 1, onCreate: _createDataBase);
    return db;
  }

  _createDataBase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE mytasksave(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL, note TEXT NOT NULL, dateAndTime TEXT NOT NULL )");
  }

  Future<TaskModel> insertData(TaskModel taskModel) async {
    var dbClient = await db;
    await dbClient?.insert("mytasksave", taskModel.toMap());
    return taskModel;
  }

  Future<List<TaskModel>> getData() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM mytasksave');
    return QueryResult.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return await dbClient!.delete("mytasksave", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> upDateData(TaskModel taskModel) async {
    var dbClient = await db;
    return await dbClient!.update("mytasksave", taskModel.toMap(),
        where: 'id = ?', whereArgs: [taskModel.id]);
  }
}
