import 'package:flutter_bobo/sql/sql.dart';

abstract class ItemInterface {
  String get organization;

  String get time;

  String get studentName;

  String get price;

  String get remarks;
}

class Item implements ItemInterface {
  String organization;
  String time;
  String studentName;
  String price;
  String remarks;

  Item(
      {this.organization,
      this.time,
      this.studentName,
      this.price,
      this.remarks});

  factory Item.fromJSON(Map json) {
    return Item(
        organization: json['organization'],
        time: json['time'],
        studentName: json['student_name'],
        price: json['price'],
        remarks: json['remarks']);
  }
}

class ItemModel {
  final String table = 'item';

  Sql sql;

  ItemModel() {
    sql = Sql.setTable(table);
  }

  Future insert(Item item) {
    var result = sql.insert({
      'organization': item.organization,
      'time': item.time,
      'student_name': item.studentName,
      'price': item.price,
      'remarks': item.remarks
    });
    return result;
  }

  //获取当月的数据
  Future<List<Item>> getItemOfMonth({int year, int month}) async {
    int startTime = new DateTime(year, month, 1).millisecondsSinceEpoch;
    int endTime = new DateTime(year, month + 1, 1).millisecondsSinceEpoch - 24 * 60 * 60 * 100;
    List list = await sql.searchByTime(startTime: startTime, endTime: endTime);
    List<Item> resultList = [];
    list.forEach((item) {
      print(item);
      resultList.add(Item.fromJSON(item));
    });
    return resultList;
  }



}
