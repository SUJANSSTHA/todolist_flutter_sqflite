// ignore_for_file: prefer_const_declarations

import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
// import 'package:todolist_flutter_sqflite/Home.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  //variable
  Database? _database;
  static final dbName = "Notebook.db";
  static final dbVersion = 1;

  static final tableName = "Notes";
  static final columnTitle = "Title";
  static final columnDesc = "Description";
  static final columnId = "id";

  get database async {
    if (_database != null) return _database;
    _database = await makeDatabase();
    return _database;
  }

  makeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: createDatabase);
  }

  Future<void> createDatabase(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnDesc TEXT NOT NULL
      )
      '''
    );
  }

  // CRUD Operations
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(tableName, row, where: '$columnId = ?', whereArgs: [row[columnId]]);
  }
}
