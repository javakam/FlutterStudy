import 'package:flutter/material.dart';

//1. findAncestorWidgetOfExactType -> Scaffold
class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在Widget树中向上查找最近的父级`Scaffold` widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接返回 AppBar的title， 此处实际上是 Text("Context测试")
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}

//2. findAncestorStateOfType -> ScaffoldState
class ContextRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("子树中获取State对象"),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              // 查找父级最近的Scaffold对应的ScaffoldState对象
              ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
              //调用ScaffoldState的showSnackBar来弹出SnackBar
              _state.showSnackBar(
                SnackBar(content: Text("我是SnackBar")),
              );

              // 或者 直接通过of静态方法来获取ScaffoldState
              // ScaffoldState _state2=Scaffold.of(context);
              // _state2.showSnackBar(
              //   SnackBar(
              //     content: Text("我是SnackBar222"),
              //   ),
              // );
            },
            child: Text("显示SnackBar"),
          );
        }),
      ),
    );
  }
}
