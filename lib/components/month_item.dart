import 'package:flutter/material.dart';
import 'package:flutter_bobo/components/school_item.dart';

class MonthItemContainer extends StatelessWidget {
  final int columnCount;

  MonthItemContainer({Key key, @required this.columnCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _listChild = [];

    for (var i = 0; i < this.columnCount; ++i) {
      _listChild.add(Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                '第${i}个学校，收入${i}元',
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.left,
              ),
              SchoolItemContainer(columnCount: 10),
            ],
          )));
    }

    return Column(
      children: _listChild,
    );
  }
}
