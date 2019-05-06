import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bobo/model/item.dart';
import 'package:flutter_bobo/resources/font_size.dart';

GlobalKey<ScaffoldState> _scaffoldKey;

TextEditingController _controllerOriginal;

TextEditingController _controllerName;

TextEditingController _controllerPrice;

TextEditingController _controllerRemakes;

var _dateTime;

class AddDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _controllerOriginal = new TextEditingController();
    _controllerName = new TextEditingController();
    _controllerPrice = new TextEditingController();
    _controllerRemakes = new TextEditingController();

    return _AddDialogState();
  }
}

class _AddDialogState extends State<AddDialog> {
  ItemModel _itemModel = new ItemModel();
  DateTime _dateTimeCurrent = new DateTime.now();
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    if (_dateTime == null) {
      _dateTime = _getDateTimeString(_dateTimeCurrent);
    }
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("添加"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () {
                  _insertSql();
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
          keyboardType: TextInputType.number,
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
        initialDate: _dateTimeCurrent,
        firstDate: new DateTime(_dateTimeCurrent.year - 1),
        lastDate: new DateTime(_dateTimeCurrent.year + 1));
    if (picked != null)
      setState(() {
        _dateTimeCurrent = picked;
        _dateTime = _getDateTimeString(picked);
      });
  }

  String _getDateTimeString(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    return '$year-$month-$day';
  }

  void _insertSql() {
    if (_controllerOriginal.value.text.isEmpty) {
      showSnackBar('_controllerOriginal is empty');
    } else if (_controllerName.value.text.isEmpty) {
      showSnackBar('_controllerName is empty');
    } else if (_controllerPrice.value.text.isEmpty) {
      showSnackBar('_controllerPrice is empty');
    } else {
      _itemModel
          .insert(Item(
              organization: _controllerOriginal.value.text,
              studentName: _controllerName.value.text,
              price: _controllerPrice.value.text,
              time: _dateTimeCurrent.millisecondsSinceEpoch.toString(),
              remarks: _controllerRemakes.value.text))
          .then((result) {
        if (this.mounted) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('添加成功')));
          _timer = new Timer.periodic(
              Duration(seconds: 3),
              (Timer timer) => setState(() {
                    Navigator.pop(context);
                  }));
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllerOriginal.dispose();
    _controllerName.dispose();
    _controllerPrice.dispose();
    _controllerRemakes.dispose();
    super.dispose();
  }

  void showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.blueAccent,
      duration: const Duration(seconds: 2),
    ));
  }
}
