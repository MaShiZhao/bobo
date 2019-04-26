import 'package:flutter/material.dart';

class SchoolItemContainer extends StatelessWidget {
  final int columnCount;

  SchoolItemContainer({Key key, @required this.columnCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _listChild = [];

    for (var i = 0; i < this.columnCount; ++i) {
      _listChild.add(Text(
        '${i}学生',
        style: Theme.of(context).textTheme.body1,
        textAlign: TextAlign.left,
      ));
    }

    return Column(
      children: _listChild,
    );
  }
}
