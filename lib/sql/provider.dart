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
    }
    bool tableIsRight = await this.checkTableIsRight();
    if (!tableIsRight) {
      db.close();
      db = await openDatabase(path, version: 2,
          onCreate: (Database db, int version) async {
            print('db created version is $version');
            await db.execute(" CREATE TABLE item ("
                "id INTEGER PRIMARY KEY,"
                "organization TEXT,"
                "time TEXT,"
                "student_name TEXT,"
                "price TEXT,"
                "remarks TEXT"
                ")");
          }, onOpen: (Database db) async {
            print(' new db opened ');
          });
    }
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ['item'];

    List<String> tables = await getTables();

    for(int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }

  // 获取数据库中所有的表
  Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item)  {
      targetList.add(item['name']);
    });
    return targetList;
  }

}
