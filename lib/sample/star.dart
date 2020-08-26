import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StarWidget extends StatelessWidget {
  /// 返回一个居中带图标和文本的Item
  _getBottomItem(BuildContext context, IconData icon, String text) {
    ///充满 Row 横向的布局
    return new Expanded(
        flex: 1,

        ///居中显示
        child: new RaisedButton(
          onPressed: () {
            //Toast with No Build Context
            Fluttertoast.showToast(
                msg: "$text",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.yellow,
                fontSize: 16.0);

            //Toast with BuildContext
//            new FToast(context).showToast(
//              child: new Container(
//                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(25.0),
//                  color: Colors.greenAccent,
//                ),
//                child: Row(
//                  mainAxisSize: MainAxisSize.min,
//                  children: [
//                    Icon(Icons.check),
//                    SizedBox(
//                      width: 12.0,
//                    ),
//                    Text("This is a Custom Toast $text"),
//                  ],
//                ),
//              ),
//              gravity: ToastGravity.BOTTOM,
//              toastDuration: Duration(seconds: 1),
//            );
          },
          child: new Center(
            ///横向布局
            child: new Row(
              ///主轴居中,即是横向居中
              mainAxisAlignment: MainAxisAlignment.center,

              ///大小按照最大充满
              mainAxisSize: MainAxisSize.max,

              ///竖向也居中
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ///一个图标，大小16.0，灰色
                new Icon(
                  icon,
                  size: 16.0,
                  color: Colors.grey,
                ),

                ///间隔
                new Padding(padding: new EdgeInsets.only(left: 5.0)),

                ///显示文本
                new Text(
                  text,
                  //设置字体样式：颜色灰色，字体大小14.0
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                  //超过的省略为...显示
                  overflow: TextOverflow.ellipsis,
                  //最长一行
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      ///四周10大小的 margin
      margin: EdgeInsets.all(10.0),
      height:300.0,
      width: 500.0,
      ///透明黑色遮罩
      decoration: new BoxDecoration(

          ///弧度为4.0
          borderRadius: BorderRadius.all(Radius.circular(4.0)),

          ///设置了decoration的color，就不能设置Container的color。
          color: Colors.lightGreenAccent,

          ///边框
          border: new Border.all(color: Colors.lightBlueAccent, width: 0.3)),

      ///卡片包装
      child: new Card(

          ///增加点击效果
          child: new FlatButton(
              onPressed: () {
                print("点击了哦");
              },
              color: Colors.white60,
              textColor: Colors.deepOrange,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(0.0),
              splashColor: Colors.tealAccent,
              child: new Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: new Padding(
                  padding: new EdgeInsets.only(left: 0.0, top: 10.0, right: 10.0, bottom: 0.0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ///文本描述
                      new Container(
                          child: new Text(
                            "这是一点描述",
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 14.0,
                            ),

                            ///最长三行，超过 ... 显示
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                          alignment: Alignment.bottomCenter),
                      new Padding(padding: EdgeInsets.all(10.0)),

                      ///三个平均分配的横向图标文字
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _getBottomItem(context, Icons.star, "666"),
                          _getBottomItem(context, Icons.link, "2333"),
                          _getBottomItem(context, Icons.android, "996"),
                        ],
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
