import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  LocalDatabase._();
  static final LocalDatabase db = LocalDatabase._();
  static Database _database;

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "porcentagem.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE semana1 ("
          "materia TEXT UNIQUE,"
          "total INTEGER,"
          "acerto INTEGER,"
          "erros INTEGER);");

      await db.execute("CREATE TABLE semana2 ("
          "materia TEXT UNIQUE,"
          "total INTEGER,"
          "acerto INTEGER,"
          "erros INTEGER);");

      await db.execute("CREATE TABLE semana3 ("
          "materia TEXT UNIQUE,"
          "total INTEGER,"
          "acerto INTEGER,"
          "erros INTEGER);");

      await db.execute("CREATE TABLE semana4 ("
          "materia TEXT UNIQUE,"
          "total INTEGER,"
          "acerto INTEGER,"
          "erros INTEGER);");

      await db.execute("CREATE TABLE geral ("
          "materia TEXT UNIQUE,"
          "total INTEGER,"
          "acerto INTEGER,"
          "erros INTEGER);");
    });
  }

  insert(
      String materia, int total, int acerto, int erros, String semana) async {
    final db = await database;

    try {
      var data;
      data = await db.rawInsert(
          "INSERT INTO $semana (materia,total,acerto,erros) VALUES ('$materia','$total', '$acerto', $erros); ");
      return data;
    } catch (e) {
      return e;
    }
  }

  update(
      String semana, int acerto, int erros, String materia, int total) async {
    final db = await database;
    var data = await db.update(
      semana,
      {'acerto': '$acerto', 'erros': '$erros', 'total': '$total'},
      where: 'materia = ?',
      whereArgs: [materia],
    );

    return data;
  }

  select(String semana, String materia) async {
    final db = await database;
    var data = await db.query(semana,where: 'materia = ?',whereArgs: [materia]);

    return data.toList();
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }
}
