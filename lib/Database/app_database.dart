import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class AppDB {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    // CSA --> C=Customer S=Service A=Admin
    // DB -->Database

    return sql.openDatabase(
      path.join(dbPath, 'Database.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE AuthData(id TEXT, userName TEXT, storeName TEXT, email TEXET, password TEXT, phoneNumber TEXT)',
        );

        db.execute(
          'CREATE TABLE AppConfigurations(version INTEGER, language TEXT, updateProductsDate TEXT)',
        );
        db.execute(
          'CREATE TABLE Favourites(productId INTEGER)',
        );
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await AppDB.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await AppDB.database();
    return db.query(table);
  }

  static Future<void> update({
    String table,
    Map<String, Object> data,
    String whereStatement,
    String whereValue,
  }) async {
    final db = await AppDB.database();
    if (whereStatement == null) {
      db.update(
        table,
        data,
      );
    } else {
      db.update(
        table,
        data,
        where: whereStatement,
        whereArgs: [
          whereValue,
        ],
      );
    }
  }

  static Future<void> delete({
    String table,
    String whereStatement,
    dynamic whereValue,
  }) async {
    final db = await AppDB.database();
    db.delete(
      table,
      //
      where: whereStatement,
      //
      whereArgs: [
        whereValue,
      ],
    );
  }

  static Future<List<Map<String, dynamic>>> select({
    String table,
    String whereStatement,
    String whereValue,
  }) async {
    final db = await AppDB.database();
    List<Map<String, dynamic>> output;
    if (whereStatement == null) {
      output = await db.rawQuery(
        "SELECT * FROM " + table,
      );
    } else {
      output = await db.rawQuery(
        "SELECT * FROM " + table + " WHERE " + whereStatement,
        [
          whereValue,
        ],
      );
    }

    return output;
  }

  static Future<void> clearTable({
    String table,
  }) async {
    final db = await AppDB.database();
    db.delete(
      table,
    );
  }
}
