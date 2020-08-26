import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/const.dart';
import 'package:flutter_app/flutterchina/context.dart';
import 'package:flutter_app/flutterchina/text.dart';
import 'package:flutter_app/flutterchina/theme_cupertino.dart';
import 'package:flutter_app/sample/star.dart';
import 'package:flutter_app/sample/toast_context.dart';
import 'package:flutter_app/sample/toast_no_context.dart';
import 'package:flutter_app/sample/widgets.dart';
import 'package:flutter_app/sample/demo_page.dart';
import 'package:flutter_app/flutterchina/my_home_page.dart';
import 'package:flutter_app/flutterchina/route_return_value.dart';
import 'package:flutter_app/flutterchina/state_lifecycle.dart';
import 'package:flutter_app/flutterchina/state_management.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  //注意：使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      //应用名称
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //注册路由表
      routes: {
        page_home_page: (context) => MyHomePage(),
        page_decoration: (context) => BoxDecorationTestWidget(),
        page_column: (context) => ExpandedWidget(),
        page_new_route: (context) => NewRoute(),
        page_star: (context) => StarWidget(),
        page_toast_context: (context) => ToastContext(),
        page_toast_context_no: (context) => ToastNoContext(),
        page_router_return_value: (context) => RouterTestRoute(),
        page_counter: (context) => CounterWidget(),
        page_context: (context) => ContextRoute(),
        page_context2: (context) => ContextRoute2(),
        page_cupertino: (context) => CupertinoTestRoute(),
        //状态管理
        page_state: (context) => TapboxA(),
        page_state2: (context) => ParentWidget(),
        page_state3: (context) => ParentWidgetC(),

        // If the home property is specified, the routes table cannot include an entry for "/",
        // since it would be redundant.
        // "/": (context) => MyHomePage(title: 'Home Page'), //注册首页路由
      },
      //应用首页路由
      //initialRoute:"/", //名为"/"的路由作为应用的home(首页)

      //注意，onGenerateRoute只会对命名路由生效。
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
          return ParentWidget();
        });
      },
      //navigatorObservers 和 onUnknownRoute 两个回调属性，前者可以监听所有路由跳转动作，后者在打开一个不存在的命名路由时会被调用

      //or 应用首页路由
      home: Scaffold(
        key: _globalKey, //设置key
        appBar: AppBar(
          title: Text('Flutter'),
        ),
        body: Container(
          child: TextTestWidget(),
        ),
      ),
      //Drawer , FloatingActionButton ...
    );
  }
}

class _SamplesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.topLeft,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(2.0),
        children: <Widget>[
          _item(context, 'MyHomePage 👉 my_home_page.dart', page_home_page),
          _item(context, 'BoxDecorationTestWidget 👉 widgets.dart', page_decoration),
          _item(context, 'ExpandedWidget 👉 widgets.dart', page_column),
          _item(context, 'StarWidget 👉 star.dart', page_star, arguments: [666, null.toString()]),
          _item(context, 'ToastContext 👉 toast_context.dart', page_toast_context),
          _item(context, 'ToastNoContext 👉 toast_no_context.dart', page_toast_context_no),
          _item(context, 'RouterTestRoute 👉 route_return_value.dart', page_router_return_value),
          _item(context, 'CounterWidget 👉 state_lifecycle.dar', page_counter),
          _item(context, 'ContextRoute 👉 context.dart', page_context),
          _item(context, 'ContextRoute2 👉 context.dart', page_context2),
          _item(context, 'CupertinoTestRoute 👉 theme_cupertino.dart', page_cupertino),
          _item(context, 'TapboxA 👉 state_management.dart', page_state),
          _item(context, 'ParentWidget 👉 state_management.dart', page_state2),
          _item(context, 'ParentWidgetC 👉 state_management.dart', page_state3),
        ],
      ),
    );
  }
}

Widget _item(
  BuildContext context,
  text,
  page, {
  Object arguments,
}) =>
    new Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: new RaisedButton(
            focusColor: Colors.cyan,
            child: new Text(text.toString()),
            onPressed: () {
              Navigator.pushNamed(context, page, arguments: arguments);
            }),
      ),
    );
