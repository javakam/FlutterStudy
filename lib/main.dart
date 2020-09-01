import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/08_layout_widgets.dart';
import 'package:flutter_app/flutterchina/09_container_widgets.dart';
import 'package:flutter_app/flutterchina/10_scrollable_widgets.dart';
import 'package:flutter_app/flutterchina/11_function.dart';
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
  page_layout_row: (context) => RowTestWidget(),
  page_layout_column: (context) => ColumnTestWidget(),
  page_layout_special: (context) => SpecialTestWidget(),
  page_layout_flex: (context) => FlexLayoutTestRoute(),
  page_layout_wrap: (context) => WrapTestWidget(),
  page_layout_flow: (context) => FlowTestWidget(),
  page_layout_stack_positioned: (context) => StackPositionedTestWidget(),
  page_layout_align: (context) => AlignTestWidget(),
  page_container: (context) => ContainerTestWidget(),
  page_container_transform: (context) => TransformTestWidget(),
  page_container_scaffold: (context) => ScaffoldTestWidget(),
  page_container_clip: (context) => ClipTestWidget(),
  page_scrollable_singlechildscrollview: (context) => SingleChildScrollViewTestWidget(),
  page_scrollable_listview_builder: (context) => ListViewTestWidget(),
  page_scrollable_listview_separated: (context) => ListViewTestWidget2(),
  page_scrollable_listview_infinite: (context) => InfiniteListView(),
  page_scrollable_listview_fixed_header: (context) => ListViewTestWidget3(),
  page_scrollable_gridview_fixed: (context) => GridTestWidget(),
  page_scrollable_gridview_max: (context) => GridTestWidget2(),
  page_scrollable_gridview_infinite: (context) => InfiniteGridView(),
  page_scrollable_gridview_staggered: (context) => StaggeredGridViewTestWidget(),
  page_scrollable_scrollview: (context) => CustomScrollViewTestRoute(),
  page_scrollable_listener: (context) => ScrollControllerTestRoute(),
  page_scrollable_notification: (context) => ScrollNotificationTestRoute(),
  page_func_willpopscope: (context) => WillPopScopeTestRoute(),
  page_func_inherit_widget: (context) => InheritedWidgetTestRoute(),
  //
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
        reverse: true,
        shrinkWrap: false,
        //itemExtent: 45,
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
          _item(context, '布局👉Row', page_layout_row),
          _item(context, '布局👉Column', page_layout_column),
          _item(context, '布局👉特殊情况', page_layout_special),
          _item(context, '布局👉Flex', page_layout_flex),
          _item(context, '布局👉Wrap', page_layout_wrap),
          _item(context, '布局👉Flow', page_layout_flow),
          _item(context, '布局👉Stack/Positioned', page_layout_stack_positioned),
          _item(context, '布局👉Align/Alignment/FractionalOffset', page_layout_align),
          _item(
              context,
              '容器👉Padding/ConstrainedBox/UnconstrainedBox/多重限制/DecoratedBox/AspectRatio/LimitedBox/FractionallySizedBox',
              page_container),
          _item(context, '容器👉Transform/RotatedBox/Container', page_container_transform),
          _item(context, '容器👉Scaffold', page_container_scaffold),
          _item(context, '容器👉剪裁👉ClipOval/ClipRRect/ClipRect', page_container_clip),
          _item(context, '滚动👉SingleChildScrollView', page_scrollable_singlechildscrollview),
          _item(context, '滚动👉ListView.builder', page_scrollable_listview_builder),
          _item(context, '滚动👉ListView.separated', page_scrollable_listview_separated),
          _item(context, '滚动👉ListView动态加载列表(模拟网络加载)', page_scrollable_listview_infinite),
          _item(context, '滚动👉ListView添加固定列表头👉Column + Expanded',
              page_scrollable_listview_fixed_header),
          _item(context, '滚动👉GridView👉SliverGridDelegateWithFixedCrossAxisCount/GridView.count',
              page_scrollable_gridview_fixed),
          _item(context, '滚动👉GridView👉SliverGridDelegateWithMaxCrossAxisExtent/GridView.extent',
              page_scrollable_gridview_max),
          _item(context, '滚动👉GridView动态加载列表(模拟网络加载)', page_scrollable_gridview_infinite),
          _item(context, '滚动👉瀑布流👉StaggeredGridView/SliverStaggeredGrid',
              page_scrollable_gridview_staggered),
          _item(context, '滚动👉Sliver👉CustomScrollView', page_scrollable_scrollview),
          _item(context, '滚动👉滚动监听及控制👉ScrollController/ScrollPosition/PageStorageKey',
              page_scrollable_listener),
          _item(context, '滚动👉滚动通知👉NotificationListener', page_scrollable_notification),
          _item(context, '双击退出👉WillPopScope', page_func_willpopscope),
          _item(context, '数据共享👉InheritedWidget', page_func_inherit_widget),
          //
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
