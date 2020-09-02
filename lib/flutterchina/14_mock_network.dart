import 'package:flutter/material.dart';

///异步UI更新（FutureBuilder、StreamBuilder）
Future<String> _mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

/*
enum ConnectionState {
  none,     /// 当前没有异步任务，比如[FutureBuilder]的[future]为null时
  waiting,  /// 异步任务处于等待状态
  active,   /// Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
  done,     /// 异步任务已经终止.
}

注意，ConnectionState.active只在StreamBuilder中才会出现。
 */
class MockNetworkRoute extends StatefulWidget {
  MockNetworkRoute({Key key}) : super(key: key);

  @override
  _MockNetworkRouteState createState() {
    return _MockNetworkRouteState();
  }
}

class _MockNetworkRouteState extends State<MockNetworkRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build...");
    return Scaffold(
      appBar: AppBar(title: Text("FutureBuilder")),
      body: Center(
        child: FutureBuilder<String>(
          future: _mockNetworkData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return Text("Contents: ${snapshot.data}");
              }
            } else {
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

///StreamBuilder
/*
StreamBuilder可以接收多个异步操作的结果，它常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。
StreamBuilder正是用于配合Stream来展示流上事件（数据）变化的UI组件。

注意:实际开发中, 凡是UI会依赖多个异步数据而发生变化的场景都可以使用 StreamBuilder。
 */
Stream<int> _counter() {
  return Stream.periodic(Duration(seconds: 3), (i) {
    return i;
  });
}

class MockNetworkMultiRoute extends StatefulWidget {
  MockNetworkMultiRoute({Key key}) : super(key: key);

  @override
  _MockNetworkMultiRouteState createState() {
    return _MockNetworkMultiRouteState();
  }
}

class _MockNetworkMultiRouteState extends State<MockNetworkMultiRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamBuilder")),
      body: StreamBuilder<int>(
        stream: _counter(), //
        //initialData: ,// a Stream<int> or null
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('没有Stream');
            case ConnectionState.waiting:
              return Text('等待数据...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return Text('Stream已关闭');
          }
          return null; // unreachable
        },
      ),
    );
  }
}
