import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/const.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = 'Flutter Demo Home Page'}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "_MyHomePageState"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                //导航到新路由
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return NewRoute();
                // }));

                //使用路由 别名
                //Navigator.pushNamed(context, page_new_route, arguments: ['abc', 23, null.toString(), "hi"]);
                Navigator.of(context)
                    .pushNamed(page_new_route, arguments: ['abc', 23, null.toString(), "hi"]);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments as List<Object>;
    for (var obj in args) {
      print("路由参数 : " + obj.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}
