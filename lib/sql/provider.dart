import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Provider {
  static Database db;

  Future init(bool isCreate) async {
    String dataBasesPath = await getDatabasesPath();
    String path = join(dataBasesPath, 'flutter.db');

    try {
      db = await openDatabase(path);
      print('opening existing database');
    } catch (e) {
      print(" Error  $e");
      db.close();
      await deleteDatabase(path);
      ByteData data = await rootBundle.load(join("assets", "app.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        print('db created version is $version');
        await db.execute(" CREATE TABLE Client ("
            "id INTEGER PRIMARY KEY,"
            "organization TEXT,"
            "time LONG,"
            "student_name TEXT,"
            "price REAL,"
            "remarks TEXT"
            ")");

      }, onOpen: (Database db) async {
        print(' new db opened ');
      });
    }
  }

  Future checkTablesRight() async {
    return false;
  }
}
