import 'package:flutter/material.dart';

class BoxDecorationTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BoxDecoration'),
      ),
      body: Container(
          //四周10大小的maring
          margin: EdgeInsets.all(10.0),
          height: 120.0,
          width: 500.0,
          //透明黑色遮罩
          decoration: new BoxDecoration(
              //弧度为4.0
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //设置了decoration的color，就不能设置Container的color。
              color: Colors.teal,
              //边框
              border: new Border.all(color: Colors.red, width: 2.3)),
          child: new Text("666666")),
    );
  }
}

class ExpandedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column Expanded'),
      ),
      body: new Column(
        verticalDirection: VerticalDirection.up,
        //主轴居中,即是竖直向居中
        mainAxisAlignment: MainAxisAlignment.center,
        //大小按照最小显示
        mainAxisSize: MainAxisSize.min,
        //横向也居中
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //flex默认为1
          new Expanded(
            child: new Text("1111"),
            flex: 2,
          ),
          new Expanded(child: new Text("2222")),
          new Expanded(child: new Text("3333")),
          new Expanded(child: new Text("4444")),
          new Expanded(child: new Text("5555")),
        ],
      ),
    );
  }
}
