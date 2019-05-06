import 'package:flutter/material.dart';
import 'package:flutter_bobo/components/school_item.dart';
import 'package:flutter_bobo/model/organization.dart';

class MonthItemContainer extends StatelessWidget {
  Map<String, Organization> organizations;

  MonthItemContainer({Key key, @required this.organizations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _listChild = [];

    organizations.forEach((key, item) {
      _listChild.add(Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$key',
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.left,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                color: Colors.transparent,
                height: 1.0,
                width: MediaQuery.of(context).size.width,
              ),
              SchoolItemContainer(students: item.students),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                color: Colors.grey,
                height: 1.0,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          )));
    });

    return Column(
      children: _listChild,
    );
  }
}
