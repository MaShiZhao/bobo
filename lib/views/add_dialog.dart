import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bobo/resources/font_size.dart';

TextEditingController _controllerOriginal,
    _controllerTime,
    _controllerName,
    _controllerPrice,
    _controllerRemakes;

var _dateTime;

DateTime _dateTimeNow = new DateTime.now();

class AddDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddDialogState();
  }
}

class _AddDialogState extends State<AddDialog> {
  @override
  Widget build(BuildContext context) {
//    _controllerOriginal = new TextEditingController();
    if (_dateTime == null) {
      _dateTime = _getDateTimeString(_dateTimeNow);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("添加"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.add) , onPressed: (){
              Fluttertoast.showToast(msg: "add");
             })
          ],

        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildOrganization(),
            _buildTime(),
            _buildStudentName(),
            _buildPrices(),
            _buildRemarks(),
          ],
        ));
  }

  _buildOrganization() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: 20,
          height: 100,
        ),
        new Text(
          "机构名称:",
          style: new TextStyle(fontSize: FontSize.NORMAL),
        ),
        new Container(width: 10, height: 1),
        new Expanded(
            child: new TextField(
          controller: _controllerOriginal,
          decoration:
              new InputDecoration(hintText: '请输入机构名称', fillColor: Colors.grey),
        )),
        new Container(
          width: 20,
          height: 1,
        ),
      ],
    );
  }

  _buildTime() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: 20,
          height: 100,
        ),
        new Text(
          "授课时间:",
          style: new TextStyle(fontSize: FontSize.NORMAL),
        ),
        new Container(width: 10, height: 1),
        new GestureDetector(
          onTap: () {
            _showDate();
          },
          child: new Text(
            '$_dateTime',
            style: new TextStyle(fontSize: FontSize.SMALL),
          ),
        ),
        new Container(
          width: 20,
          height: 1,
        ),
      ],
    );
  }

  _buildStudentName() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: 20,
          height: 100,
        ),
        new Text(
          "学生姓名:",
          style: new TextStyle(fontSize: FontSize.NORMAL),
        ),
        new Container(width: 10, height: 1),
        new Expanded(
            child: new TextField(
          controller: _controllerName,
          decoration:
              new InputDecoration(hintText: '请输入学生姓名', fillColor: Colors.grey),
        )),
        new Container(
          width: 20,
          height: 1,
        ),
      ],
    );
  }

  _buildPrices() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: 20,
          height: 100,
        ),
        new Text(
          "授课价格:",
          style: new TextStyle(fontSize: FontSize.NORMAL),
        ),
        new Container(width: 10, height: 1),
        new Expanded(
            child: new TextField(
          controller: _controllerPrice,
          decoration:
              new InputDecoration(hintText: '请输入授课价格', fillColor: Colors.grey),
        )),
        new Container(
          width: 20,
          height: 1,
        ),
      ],
    );
  }

  _buildRemarks() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: 20,
          height: 100,
        ),
        new Text(
          "       备注:",
          style: new TextStyle(fontSize: FontSize.NORMAL),
        ),
        new Container(width: 10, height: 1),
        new Expanded(
            child: new TextField(
          controller: _controllerRemakes,
          decoration: new InputDecoration(
            hintText: '请输入备注',
            fillColor: Colors.grey,
          ),
        )),
        new Container(
          width: 20,
          height: 1,
        ),
      ],
    );
  }

  Future _showDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTimeNow,
        firstDate: new DateTime(_dateTimeNow.year - 1),
        lastDate: new DateTime(_dateTimeNow.year + 1));
    if (picked != null)
      setState(() {
        _dateTime = _getDateTimeString(picked);
      });
  }

  String _getDateTimeString(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    return '$year-$month-$day';
  }
}
