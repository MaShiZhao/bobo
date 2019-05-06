import 'package:flutter/material.dart';
import 'package:flutter_bobo/model/organization.dart';

class SchoolItemContainer extends StatelessWidget {
  List<Student> students;

  SchoolItemContainer({Key key, @required this.students}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _listChild = [];

    students.forEach((item) {
      _listChild.add(Text(
        '${item.name}  ￥${item.prices}',
        style: Theme.of(context).textTheme.body1,
        textAlign: TextAlign.left,
      ));
    });

    return Column(
      children: _listChild,
    );
  }
}
