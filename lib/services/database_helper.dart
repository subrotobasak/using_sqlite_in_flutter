import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:using_sqlite_in_flutter/model/note_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'Note.db';

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL);"),version: _version);
  }

  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    return await db.insert('Note', note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update('Note', note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete(
      'Note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<Note>?> getAllNote() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Note');
    if (maps.isEmpty) {
      return null;
    } else {
      return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
    }
  }
}
