import 'package:flutter/material.dart';
import 'package:flutter_bobo/components/month_item.dart';
import 'package:flutter_bobo/sql/provider.dart';

void main() async {
  final provider = new Provider();
  await provider.init(true);
  runApp(MyApp());
}

double screenWidth, screenHeight;

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//创建月份的item布局
_buildMonthChild() {
  MonthItemContainer monthChildContainer = MonthItemContainer(columnCount: 10);

  return Container(
    color: Colors.white,
    height: screenHeight,
    child: monthChildContainer,
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    screenHeight = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("四月"),
      ),
      body: ListView(
        children: <Widget>[
          _buildMonthChild(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _incrementCounter(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('免责声明'),
          content: SingleChildScrollView(
            child: Text('免责声明',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)), // 圆角

          actions: <Widget>[
            new Container(
              width: 250,
            )
          ],
        );
      },
    );
  }
}
