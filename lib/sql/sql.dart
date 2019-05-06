import 'package:flutter_bobo/sql/provider.dart';
import 'package:sqflite/sqflite.dart';

class BaseModel {
  Database db;
  final String table = '';
  var query;

  BaseModel(this.db) {
    query = db.query;
  }
}

class Sql extends BaseModel {
  final String tableName;

  Sql.setTable(String name)
      : tableName = name,
        super(Provider.db);

  String getTableName() {
    return tableName;
  }

  Future<List> get() async {
    return await this.query(tableName);
  }

  Future<int> delete(String value, String key) async {
    return await this
        .db
        .delete(tableName, where: '$key = ?', whereArgs: [value]);
  }

  Future<List> getByCondition({Map<dynamic, dynamic> conditions}) async {
    if (conditions == null || conditions.isEmpty) {
      return this.get();
    }

    String stringConditions = '';

    int index = 0;
    conditions.forEach((key, value) {
      if (value == null) return;

      if (value.runtimeType == String) {
        stringConditions = '$stringConditions $key = "$value" ';
      }

      if (value.runtimeType == int) {
        stringConditions = '$stringConditions $key = $value';
      }

      if (index >= 0 && index < conditions.length - 1) {
        stringConditions = '$stringConditions and';
      }

      index++;
    });

    return await this.query(tableName, where: stringConditions);
  }

  Future<Map<String, dynamic>> insert(Map<String, dynamic> json) async {
    var id = await this.db.insert(tableName, json);
    json['id'] = id;
    return json;
  }

  ///
  /// 搜索
  /// @param Object condition
  /// @mods [And, Or] default is Or
  /// search({'name': "hanxu', 'id': 1};
  ///
  Future<List> searchByTime({int startTime, int endTime}) async {
    String stringConditions = 'time > $startTime And time <  $endTime';
    return await this.query(tableName, where: stringConditions);
  }
}
