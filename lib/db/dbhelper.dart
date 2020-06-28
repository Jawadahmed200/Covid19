import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databasename = "covid.db";
  static final _databaseversion = 2;
  static final table = "con_table";

  static final colid = "id";
  static final colname = "name";

  DatabaseHelper._privateconstructor();
  static final DatabaseHelper instannce = DatabaseHelper._privateconstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        $colid INTEGER PRIMARY KEY,
        $colname TEXT NOT NULL
        
      )
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instannce.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instannce.database;

    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryspec(int id) async {
    Database db = await instannce.database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleterow(int id) async {
    Database db = await instannce.database;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> update(Map<String, dynamic> row, int id) async {
    Database db = await instannce.database;
    var res = await db.update(table, row, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
