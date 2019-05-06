import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bobo/components/month_item.dart';
import 'package:flutter_bobo/sql/provider.dart';
import 'package:flutter_bobo/views/add_dialog.dart';

import 'model/item.dart';
import 'model/organization.dart';
import 'routers/application.dart';

void main() async {
  final provider = new Provider();
  await provider.init(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '波波记一笔',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '波波记一笔'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double screenWidth, screenHeight;
  Map<String, Organization> organizations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ItemModel _itemModel = new ItemModel();
    List<Item> items = [];
    organizations = new HashMap();
    _itemModel
        .getItemOfMonth(
            year: Application.dateTimeCurrent.year,
            month: Application.dateTimeCurrent.month)
        .then((resultList) {
      print("-----");
      print(resultList.toString());
      resultList.forEach((item) {
        items.add(item);
      });

      organizations.clear();
      items.forEach((item) {
        Student student =
            new Student(item.studentName, item.time, double.parse(item.price));
        if (organizations.keys.contains(item.organization)) {
          organizations[item.organization].students.add(student);
        } else {
          Organization organization = new Organization(item.organization);
          organization.students.add(student);
          organizations[item.organization] = organization;
        }
      });

      if (this.mounted) {
        setState(() {
          organizations = organizations;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("${Application.dateTimeCurrent.year}年${Application.dateTimeCurrent.month}月"),
      ),
      body: ListView(
        children: <Widget>[
          _buildMonthChild(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new AddDialog()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //创建月份的item布局
  _buildMonthChild() {
    MonthItemContainer monthChildContainer =
        MonthItemContainer(organizations: organizations);

    return Container(
      color: Colors.white,
      height: screenHeight,
      child: monthChildContainer,
    );
  }
}
