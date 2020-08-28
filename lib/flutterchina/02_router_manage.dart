import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/const.dart';

///Navigator + MaterialPageRoute
class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Parent Widget build..........");

    return Scaffold(
      appBar: AppBar(
        title: Text("Navigator+MaterialPageRoute"),
      ),
      body: Column(
        children: [
          Center(
            child: RaisedButton(
              onPressed: () async {
                // 打开`TipRoute`，并等待返回结果
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return _TipRoute(
                        // 路由参数
                        text: "我是提示xxxx",
                      );
                    },
                    //路由参数
                    //settings: RouteSettings(),
                  ),
                );
                //输出`TipRoute`路由返回结果
                print("路由返回值: $result");
              },
              child: Text("打开提示页(构造器传参)"),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                // 打开`TipRouteWithArgs`，并等待返回结果
                var result = await Navigator.pushNamed(context, page_router_args_stateless,
                    arguments: ['abc', 23, null.toString(), "hello world"]);

                // var result = await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return TipRouteWithArgs(
                //         // 路由参数
                //         arguments: ['abc', 23, null.toString(), "hello world"],
                //       );
                //     },
                //   ),
                // );

                //输出`TipRouteWithArgs`路由返回结果
                print("路由返回值: $result");
              },
              child: Text("打开提示页(arguments传参到 StatelessWidget)"),
            ),
          ),

          Center(
            child: RaisedButton(
              onPressed: () async {
                // 打开`TipRouteWithArgs`，并等待返回结果
                var result = await Navigator.pushNamed(context, page_router_args_stateful,
                    arguments: ['abc', 23, null.toString(), "hello world"]);

                //输出`TipRouteWithArgs`路由返回结果
                print("路由返回值: $result");
              },
              child: Text("打开提示页(arguments传参到 StatefulWidget)"),
            ),
          ),
        ],
      ),
    );
  }
}

///Navigator.pop
class _TipRoute extends StatelessWidget {
  _TipRoute({
    Key key,
    @required this.text, // 接收一个text参数
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    print("build..........");
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///获取路由参数 eg : ModalRoute.of(context).settings.arguments as T
class RouteWithArgsStateless extends StatelessWidget {
  RouteWithArgsStateless({Key key, Object arguments}) : super(key: key);
  String text = "";

  @override
  Widget build(BuildContext context) {
    print("build..........");

    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments as List<Object>;
    if (args == null || args.isEmpty) {
      return SizedBox();
    }
    for (var obj in args) {
      print("路由参数 : " + obj.toString());
      text += "\n ${obj.toString()}";
    }
    text = "路由参数 : \n" + text;
    args.clear();

    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, "我是返回值");
                },
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RouteWithArgsStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RouteWithArgsStatefulState();
  }
}

class _RouteWithArgsStatefulState extends State<RouteWithArgsStateful> {
  String text = "";

  @override
  void initState() {
    super.initState();

    Builder(
      // ignore: missing_return
      builder: (context){
        //获取路由参数
        var args = ModalRoute.of(context).settings.arguments as List<Object>;
        for (var obj in args) {
          print("路由参数 : " + obj.toString());
          text += "\n ${obj.toString()}";
        }
        text = "路由参数 : \n" + text;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build..........");

    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, "我是返回值");
                },
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
