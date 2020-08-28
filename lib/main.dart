import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/const.dart';
import 'package:flutter_app/flutterchina/06_basic_widgets.dart';
import 'package:flutter_app/flutterchina/03_context.dart';
import 'package:flutter_app/flutterchina/07_form.dart';
import 'package:flutter_app/flutterchina/theme_cupertino.dart';
import 'package:flutter_app/flutterchina/toast_context.dart';
import 'package:flutter_app/flutterchina/toast_no_context.dart';
import 'package:flutter_app/flutterchina/01_my_home_page.dart';
import 'package:flutter_app/flutterchina/02_router_manage.dart';
import 'package:flutter_app/flutterchina/04_state_lifecycle.dart';
import 'package:flutter_app/flutterchina/05_state_manage.dart';

import 'package:flutter_app/sample/star.dart';
import 'package:flutter_app/sample/listview_custom.dart';

var _Routers = {
  page_home_page: (context) => MyHomePage(),
  page_router_manage: (context) => RouterTestRoute(),
  page_router_args_stateless: (context) => RouteWithArgsStateless(),
  page_router_args_stateful: (context) => RouteWithArgsStateful(),
  page_context: (context) => ContextRoute(),
  page_context2: (context) => ContextRoute2(),
  page_state_lifecycle_counter: (context) => StateLifecycleCounterWidget(),
  page_state_manage_self: (context) => TapboxA(),
  page_state_manage_parent: (context) => ParentWidget(),
  page_state_manage_mixture: (context) => ParentWidgetC(),
  page_widget_basic: (context) => BasicWidgets(),
  page_widget_form: (context) => FormTestRoute(),
  page_decoration: (context) => BoxDecorationTestWidget(),
  page_column: (context) => ExpandedWidget(),
  page_toast_context: (context) => ToastContext(),
  page_toast_context_no: (context) => ToastNoContext(),
  page_theme_cupertino: (context) => CupertinoTestRoute(),
  page_eg_star: (context) => StarWidget(),
  page_eg_listview_custom: (context) => ListViewCustomPage(),

  // If the home property is specified, the routes table cannot include an entry for "/",
  // since it would be redundant.
  // "/": (context) => MyHomePage(title: 'Home Page'), //注册首页路由
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ///定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  ///注意：使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。
  ///https://book.flutterchina.club/chapter3/flutter_widget_intro.html
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      //应用名称
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        ///TextField 自定义样式
        ///basic_widgets.dart -> TextFieldTestWidget
        hintColor: Colors.grey[200], //定义下划线颜色
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.deepOrangeAccent), //定义label字体样式
          hintStyle: TextStyle(color: Colors.deepOrangeAccent, fontSize: 14.0), //定义提示文本样式
          focusColor: Colors.yellow,
        ),
      ),
      //注册路由表
      routes: _Routers,
      //应用首页路由
      //initialRoute:"/", //名为"/"的路由作为应用的home(首页)

      //or 应用首页路由
      home: Scaffold(
        key: _globalKey, //设置key eg: _globalKey.currentState.openDrawer()
        appBar: AppBar(
          title: Text('Flutter'),
        ),
        body: Container(
          child: _SamplesWidget(),
        ),
      ),

      //注意，onGenerateRoute 只会对命名路由生效。
      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute(builder: (context) {
      //     String routeName = settings.name;
      //     // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
      //     // 引导用户登录；其它情况则正常打开路由。
      //     return ParentWidget();
      //   });
      // },

      //navigatorObservers 和 onUnknownRoute 两个回调属性，前者可以监听所有路由跳转动作，后者在打开一个不存在的命名路由时会被调用
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
        padding: const EdgeInsets.all(1.0),
        children: <Widget>[
          _item(context, '默认首页', page_home_page),
          _item(context, '路由管理👉Navigator+MaterialPageRoute', page_router_manage),
          _item(context, 'Context👉findAncestorWidgetOfExactType->Scaffold', page_context),
          _item(context, 'Context👉findAncestorStateOfType->ScaffoldState', page_context2),
          _item(context, 'State生命周期', page_state_lifecycle_counter),
          _item(context, '状态管理👉Widget管理自己的状态', page_state_manage_self),
          _item(context, '状态管理👉Widget管理子Widget状态', page_state_manage_parent),
          _item(context, '状态管理👉父Widget和子Widget都管理状态', page_state_manage_mixture),
          _item(context, '基础组件👉Switch/Checkbox/TextField/Form/ProgressIndicator/Image/Icon',
              page_widget_basic),
          _item(context, '表单👉Form/TextFormField', page_widget_form),
          _item(context, '遮罩👉BoxDecoration', page_decoration),
          _item(context, '布局👉Column + Expanded', page_column),
          _item(context, '吐司带有Context', page_toast_context),
          _item(context, '吐司不带Context', page_toast_context_no),
          _item(context, '主题👉Cupertino', page_theme_cupertino),
          _item(context, '样例👉底部导航', page_eg_star, arguments: [666, null.toString()]),
          _item(context, '样例👉ListView', page_eg_listview_custom),
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
        padding: const EdgeInsets.all(0.0),
        child: new RaisedButton(
            focusColor: Colors.cyan,
            child: new Text(
              text.toString(),
              maxLines: 3,
              style: TextStyle(fontSize: 13),
            ),
            onPressed: () {
              Navigator.pushNamed(context, page, arguments: arguments);
            }),
      ),
    );
