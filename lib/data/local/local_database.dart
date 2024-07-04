import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note_model.dart';
import '../models/note_model_constants.dart';

class LocalDatabase {
  //Step 1
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  //Step 2
  Database? _database;

  //Step 3
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("notes.db");
      return _database!;
    }
  }

  //Step 4
  Future<Database> _init(String databaseName) async {
    //......Android/data
    String internalPath = await getDatabasesPath();
    //......Android/data/todos.db
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //--------------------------READY TO USE------------------------

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''CREATE TABLE ${NoteModelConstants.tableName} (
      ${NoteModelConstants.id} $idType,
      ${NoteModelConstants.title} $textType,
      ${NoteModelConstants.text} $textType,
      ${NoteModelConstants.time} $textType,
      ${NoteModelConstants.color} $textType
    )''');
  }

  //------------------NOTES--------------------------------------

  static Future<NoteModel> insertNote(NoteModel noteModel) async {
    debugPrint("INITIAL ID:${noteModel.id}");
    final db = await databaseInstance.database;
    int savedTaskID =
    await db.insert(NoteModelConstants.tableName, noteModel.toJson());
    debugPrint("SAVED ID:$savedTaskID");
    return noteModel.copyWith(id: savedTaskID);
  }

  static Future<List<NoteModel>> getAllNotes() async {
    final db = await databaseInstance.database;
    String orderBy = "${NoteModelConstants.id} DESC"; //"_id DESC"
    List json = await db.query(NoteModelConstants.tableName, orderBy: orderBy);
    return json.map((e) => NoteModel.fromJson(e)).toList();
  }

  static Future<int> deleteNote(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      NoteModelConstants.tableName,
      where: "${NoteModelConstants.id} = ?",
      whereArgs: [id],
    );
    return deletedId;
  }

  static Future<int> updateNote(
      NoteModel noteModel,
      int id,
      ) async {
    debugPrint("UPDATE: ${noteModel.toJson()} ${noteModel.id}");

    final db = await databaseInstance.database;
    int updatedTaskId = await db.update(
      NoteModelConstants.tableName,
      noteModel.toJson(),
      where: "${NoteModelConstants.id} = ?",
      whereArgs: [id],
    );
    return updatedTaskId;
  }

  static Future<List<NoteModel>> searchNote(String query) async {
    final db = await databaseInstance.database;
    var json = await db.query(
      NoteModelConstants.tableName,
      where: "${NoteModelConstants.title} LIKE ?",
      whereArgs: ["$query%"],
    );
    return json.map((e) => NoteModel.fromJson(e)).toList();
  }




  void function() {
    //000000 => Color(0xFF000000)
    var color = Colors.black;
    Color(int.parse("000000"));
    color.value.toString();
  }
}