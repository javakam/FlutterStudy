import 'package:flutter/material.dart';

class TextTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(3.0),
        children: [
          //Text
          Text(
            "Hello world",
            textAlign: TextAlign.left,
          ),

          Text(
            "Hello world! I'm Jack. " * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          Text(
            "Hello world",
            textScaleFactor: 1.5,
          ),

          //TextStyle
          Text(
            "Hello world",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.2,
                fontFamily: "Courier",
                background: new Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),

          Text.rich(TextSpan(children: [
            TextSpan(text: "Home: "),
            TextSpan(
              text: "https://flutterchina.club",
              style: TextStyle(color: Colors.blue),
              //recognizer: _tapRecognizer
            ),
          ])),

          Text('---------------------------------'),

          OutlineButton(
            child: Text("normal"),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {},
          ),

          RaisedButton.icon(
            icon: Icon(Icons.send),
            label: Text("发送"),
            onPressed: () {},
          ),

          /*
          const FlatButton({
              ...
              @required this.onPressed, //按钮点击回调
              this.textColor, //按钮文字颜色
              this.disabledTextColor, //按钮禁用时的文字颜色
              this.color, //按钮背景颜色
              this.disabledColor,//按钮禁用时的背景颜色
              this.highlightColor, //按钮按下时的背景颜色
              this.splashColor, //点击时，水波动画中水波的颜色
              this.colorBrightness,//按钮主题，默认是浅色主题
              this.padding, //按钮的填充
              this.shape, //外形
              @required this.child, //按钮的内容
            })
           */
          FlatButton.icon(
            icon: Icon(Icons.info),
            label: Text("详情"),
            onPressed: () {},
          ),

          OutlineButton.icon(
            icon: Icon(Icons.add),
            label: Text("添加"),
            onPressed: () {},
          ),

          Center(
            child: FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("Custom FlatButton"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            ),
          ),

          /*
          RaisedButton
              this.elevation = 2.0, //正常状态下的阴影
              this.highlightElevation = 8.0,//按下时的阴影
              this.disabledElevation = 0.0,// 禁用时的阴影
           */
          Center(
            child: RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("Custom RaisedButton"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            ),
          ),

        ],
      )),
    );
  }
}
