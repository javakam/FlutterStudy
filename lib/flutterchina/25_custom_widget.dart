import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/widget/widgets.dart';

///自定义组件
class CustomWidgetRoute extends StatelessWidget {
  CustomWidgetRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("自定义组件")),
        body: Column(
          children: [
            _GradientButton(),

            ///
          ],
        ));
  }
}

/*
自定义一个GradientButton组件，它需要支持一下功能：
    1.背景支持渐变色
    2.手指按下时有涟漪效果
    3.可以支持圆角
 */
class _GradientButton extends StatelessWidget {
  _GradientButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.deepOrangeAccent, Colors.red]),
        boxShadow: [
          //阴影
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        "标题",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //根据背景色亮度来确定Title颜色
          color: Colors.white,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}

///自定义组件(官网Demo)
class GradientButtonRoute extends StatefulWidget {
  @override
  _GradientButtonRouteState createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义组件(Official)")),
      body: Container(
        child: Column(
          children: <Widget>[
            GradientButton(
              colors: [Colors.orange, Colors.red],
              height: 50.0,
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightGreen, Colors.green[700]],
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightBlue[300], Colors.blueAccent],
              child: Text("Submit"),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }

  onTap() {
    print("button click");
  }
}

class TurnBoxRoute extends StatefulWidget {
  @override
  _TurnBoxRouteState createState() => new _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义组件 TurnBox")),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBox(
              turns: _turns,
              duration: 500,
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
            TurnBox(
              turns: _turns,
              duration: 1000,
              child: Icon(
                Icons.refresh,
                size: 150.0,
              ),
            ),
            RaisedButton(
              child: Text("顺时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
            ),
            RaisedButton(
              child: Text("逆时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns -= .2;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

///富文本展示组件MyRichText ，它可以自动处理url链接
class MyRichTextRoute extends StatefulWidget {
  @override
  _MyRichTextRouteState createState() => new _MyRichTextRouteState();
}

class _MyRichTextRouteState extends State<MyRichTextRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义组件 MyRichText")),
      body: Center(
        child: Column(
          children: <Widget>[
            MyRichText(
              text: "你好世界",
            ),
            SizedBox(
              height: 15,
            ),
            MyRichText(
              text: "http://www.baidu.com",
            ),
          ],
        ),
      ),
    );
  }
}

///自绘组件 （CustomPaint与Canvas）
/*
CustomPaint({
  Key key,
  this.painter,
  this.foregroundPainter,
  this.size = Size.zero,
  this.isComplex = false,
  this.willChange = false,
  Widget child, //子节点，可以为空
})

注意
如果CustomPaint有子节点，为了避免子节点不必要的重绘并提高性能，通常情况下都会将子节点包裹在RepaintBoundary组件中，
这样会在绘制时就会创建一个新的绘制层（Layer），其子组件将在新的Layer上绘制，而父组件将在原来Layer上绘制，也就是说RepaintBoundary 子组件的绘制将独立于父组件的绘制，
RepaintBoundary会隔离其子节点和CustomPaint本身的绘制边界。示例如下：

CustomPaint(
  size: Size(300, 300), //指定画布大小
  painter: MyPainter(),
  child: RepaintBoundary(child:...)),
)

画笔Paint
var paint = Paint() //创建一个画笔并配置其属性
  ..isAntiAlias = true //是否抗锯齿
  ..style = PaintingStyle.fill //画笔样式：填充
  ..color=Color(0x77cdb175);//画笔颜色
 */

///示例：五子棋/盘
/*
性能
绘制是比较昂贵的操作，所以我们在实现自绘控件时应该考虑到性能开销，下面是两条关于性能优化的建议：

1.尽可能的利用好shouldRepaint返回值；在UI树重新build时，控件在绘制前都会先调用该方法以确定是否有必要重绘；
假如我们绘制的UI不依赖外部状态，那么就应该始终返回false，因为外部状态改变导致重新build时不会影响我们的UI外观；
如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，如果已改变则应返回true来重绘，反之则应返回false不需要重绘。

2.绘制尽可能多的分层；在上面五子棋的示例中，我们将棋盘和棋子的绘制放在了一起，
这样会有一个问题：由于棋盘始终是不变的，用户每次落子时变的只是棋子，但是如果按照上面的代码来实现，每次绘制棋子时都要重新绘制一次棋盘，这是没必要的。
优化的方法就是将棋盘单独抽为一个组件，并设置其shouldRepaint回调值为false，然后将棋盘组件作为背景。然后将棋子的绘制放到另一个组件中，这样每次落子时只需要绘制棋子。

总结
自绘控件非常强大，理论上可以实现任何2D图形外观，实际上Flutter提供的所有组件最终都是通过调用Canvas绘制出来的，只不过绘制的逻辑被封装起来了，
如Text对应的RenderParagraph对象最终会通过Canvas实现文本绘制逻辑。
 */
class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自绘组件 五子棋")),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300), //指定画布大小
          painter: _MyPainter(),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
      Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
      math.min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );

    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
      math.min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

///自绘实例：圆形背景渐变进度条
class GradientCircularProgressRoute extends StatefulWidget {
  @override
  _GradientCircularProgressRouteState createState() {
    return new _GradientCircularProgressRouteState();
  }
}

class _GradientCircularProgressRouteState extends State<GradientCircularProgressRoute>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自绘组件 圆形背景渐变进度条")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 16.0,
                          children: <Widget>[
                            GradientCircularProgressIndicator(
                              // No gradient
                              colors: [Colors.blue, Colors.blue],
                              radius: 50.0,
                              strokeWidth: 3.0,
                              value: _animationController.value,
                            ),
                            GradientCircularProgressIndicator(
                              colors: [Colors.red, Colors.orange],
                              radius: 50.0,
                              strokeWidth: 3.0,
                              value: _animationController.value,
                            ),
                            GradientCircularProgressIndicator(
                              colors: [
                                Colors.red,
                                Colors.orange,
                                Colors.red,
                              ],
                              radius: 50.0,
                              strokeWidth: 5.0,
                              totalAngle: 1.5 * math.pi,
                              value: _animationController.value,
                            ),
                            GradientCircularProgressIndicator(
                              colors: [Colors.teal, Colors.cyan],
                              radius: 50.0,
                              strokeWidth: 5.0,
                              strokeCapRound: true,
                              //圆头
                              value: CurvedAnimation(
                                      parent: _animationController, curve: Curves.decelerate)
                                  .value,
                            ),
                            TurnBox(
                              turns: 1 / 8,
                              child: GradientCircularProgressIndicator(
                                  colors: [Colors.red, Colors.orange, Colors.red],
                                  radius: 50.0,
                                  strokeWidth: 5.0,
                                  strokeCapRound: true,
                                  backgroundColor: Colors.red[50],
                                  totalAngle: 1.5 * math.pi,
                                  value: CurvedAnimation(
                                          parent: _animationController, curve: Curves.bounceInOut)
                                      .value),
                            ),
                            RotatedBox(
                              quarterTurns: 1,
                              child: GradientCircularProgressIndicator(
                                  colors: [Colors.blue[700], Colors.blue[200]],
                                  radius: 50.0,
                                  strokeWidth: 3.0,
                                  strokeCapRound: true,
                                  backgroundColor: Colors.transparent,
                                  value: _animationController.value),
                            ),
                            GradientCircularProgressIndicator(
                              colors: [
                                Colors.red,
                                Colors.amber,
                                Colors.cyan,
                                Colors.green[200],
                                Colors.blue,
                                Colors.red
                              ],
                              radius: 50.0,
                              strokeWidth: 5.0,
                              strokeCapRound: true,
                              value: _animationController.value,
                            ),

                            ///自己写的
                            SizedBox(
                              height: 108.0,
                              width: 200.0,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  TurnBox(
                                    turns: -0.25,
                                    child: GradientCircularProgressIndicator(
                                        colors: [
                                          Colors.red,
                                          Colors.amber,
                                          Colors.cyan,
                                          Colors.green[200],
                                          Colors.blue,
                                          Colors.red
                                        ],
                                        radius: 50.0,
                                        strokeWidth: 5.0,
                                        strokeCapRound: true,
                                        totalAngle: math.pi,
                                        value: CurvedAnimation(
                                                parent: _animationController, curve: Curves.linear)
                                            .value),
                                  ),
                                  Center(
                                    child: Text(
                                      ///toInt 会出现达不到 100% 的问题
                                      '${(_animationController.value * 100).ceil()}%',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GradientCircularProgressIndicator(
                          colors: [Colors.blue[700], Colors.blue[200]],
                          radius: 100.0,
                          strokeWidth: 20.0,
                          value: _animationController.value,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: GradientCircularProgressIndicator(
                            colors: [Colors.blue[700], Colors.blue[300]],
                            radius: 100.0,
                            strokeWidth: 20.0,
                            value: _animationController.value,
                            strokeCapRound: true,
                          ),
                        ),
                        //剪裁半圆
                        ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: .5,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: SizedBox(
                                //width: 100.0,
                                child: TurnBox(
                                  turns: .75,
                                  child: GradientCircularProgressIndicator(
                                    colors: [Colors.teal, Colors.cyan[500]],
                                    radius: 100.0,
                                    strokeWidth: 8.0,
                                    value: _animationController.value,
                                    totalAngle: math.pi,
                                    strokeCapRound: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 104.0,
                          width: 200.0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                height: 200.0,
                                top: .0,
                                child: TurnBox(
                                  turns: .75,
                                  child: GradientCircularProgressIndicator(
                                    colors: [Colors.teal, Colors.cyan[500]],
                                    radius: 100.0,
                                    strokeWidth: 8.0,
                                    value: _animationController.value,
                                    totalAngle: math.pi,
                                    strokeCapRound: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "${(_animationController.value * 100).toInt()}%",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
