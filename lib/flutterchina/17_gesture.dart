import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///点击、双击、长按 onTap/onDoubleTap/onLongPress
/*

GestureDetector
注意： 当同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时，
这是因为当用户点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等一段时间来确定是否为双击事件。
如果用户只监听了onTap（没有监听onDoubleTap）事件时，则没有延时。
 */
class GestureDetectorTestRoute extends StatefulWidget {
  @override
  _GestureDetectorTestRouteState createState() => new _GestureDetectorTestRouteState();
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  String _operation = "No Gesture detected!"; //保存事件名
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("点击、双击、长按")),
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 200.0,
            height: 100.0,
            child: Text(
              _operation,
              style: TextStyle(color: Colors.white),
            ),
          ),
          onTap: () => _updateText("Tap"), //点击
          onDoubleTap: () => _updateText("DoubleTap"), //双击
          onLongPress: () => _updateText("LongPress"), //长按
        ),
      ),
    );
  }

  void _updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}

///拖动、滑动 onPanDown/onPanUpdate/onPanEnd
/*
一次完整的手势过程是指用户手指按下到抬起的整个过程，期间，用户按下手指后可能会移动，也可能不会移动。
GestureDetector对于拖动和滑动事件是没有区分的，他们本质上是一样的。
GestureDetector会将要监听的组件的原点（左上角）作为本次手势的原点，当用户在监听的组件上按下手指时，手势识别就会开始。


DragDownDetails.globalPosition：当用户按下时，此属性为用户按下的位置相对于屏幕（而非父组件）原点(左上角)的偏移。
DragUpdateDetails.delta：当用户在屏幕上滑动时，会触发多次Update事件，delta指一次Update事件的滑动的偏移量。
DragEndDetails.velocity：该属性代表用户抬起手指时的滑动速度(包含x、y两个轴的），示例中并没有处理手指抬起时的速度，常见的效果是根据用户抬起手指时的速度做一个减速动画。
 */
class DragRoute extends StatefulWidget {
  @override
  _DragRouteState createState() => new _DragRouteState();
}

class _DragRouteState extends State<DragRoute> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("拖动、滑动")),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(radius: 35, child: Text("A")),
              //手指按下时会触发此回调
              onPanDown: (DragDownDetails e) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails e) {
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                //打印滑动结束时在x、y轴上的速度
                print(e.velocity);
              },
            ),
          )
        ],
      ),
    );
  }
}

///单一方向拖动 onHorizontalDragUpdate/onVerticalDragUpdate
class DragVerticalRoute extends StatefulWidget {
  @override
  _DragVerticalRouteState createState() => new _DragVerticalRouteState();
}

class _DragVerticalRouteState extends State<DragVerticalRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("单一方向拖动")),
      body: Stack(
        children: <Widget>[
          Center(
              child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              '如果在上例中我们同时监听水平和垂直方向的拖动事件，那么我们斜着拖动时哪个方向会生效？'
              '实际上取决于第一次移动时两个轴上的位移分量，哪个轴的大，哪个轴在本次滑动事件竞争中就胜出。',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          )),
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
                child: CircleAvatar(radius: 35, child: Text("A")),

                ///水平方向拖动事件
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },

                ///垂直方向拖动事件
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _top += details.delta.dy;
                  });
                }),
          )
        ],
      ),
    );
  }
}

///缩放 onScaleUpdate
class ScaleTestRoute extends StatefulWidget {
  ScaleTestRoute({Key key}) : super(key: key);

  @override
  _ScaleTestRouteState createState() {
    return _ScaleTestRouteState();
  }
}

class _ScaleTestRouteState extends State<ScaleTestRoute> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("缩放 onScaleUpdate")),
      body: Center(
        child: GestureDetector(
          //指定宽度，高度自适应
          child: Image.asset("static/images/mountain.webp", width: _width),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              //缩放倍数在0.8到10倍之间
              _width = 200 * details.scale.clamp(.8, 10.0);
            });
          },
        ),
      ),
    );
  }
}

///GestureRecognizer
/*
假设我们要给一段富文本（RichText）的不同部分分别添加点击事件处理器，但是TextSpan并不是一个widget，
这时我们不能用GestureDetector，但TextSpan有一个recognizer属性，它可以接收一个GestureRecognizer。

假设我们需要在点击时给文本变色:
 */
class GestureRecognizerTestRoute extends StatefulWidget {
  GestureRecognizerTestRoute({Key key}) : super(key: key);

  @override
  _GestureRecognizerTestRouteState createState() {
    return _GestureRecognizerTestRouteState();
  }
}

class _GestureRecognizerTestRouteState extends State<GestureRecognizerTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GestureRecognizer")),
      body: Center(
        child: Text.rich(TextSpan(children: [
          TextSpan(text: "你好世界"),
          TextSpan(
            text: "点我变色",
            style: TextStyle(fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
            recognizer: _tapGestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              }
              ..onTapCancel = () {},
          ),
          TextSpan(text: "你好世界"),
        ])),
      ),
    );
  }
}
//注意：使用GestureRecognizer后一定要调用其dispose()方法来释放资源（主要是取消内部的计时器）。

///手势竞争与冲突
/*
竞争
如果在上例中我们同时监听水平和垂直方向的拖动事件，那么我们斜着拖动时哪个方向会生效？实际上取决于第一次移动时两个轴上的位移分量，哪个轴的大，哪个轴在本次滑动事件竞争中就胜出。
实际上Flutter中的手势识别引入了一个Arena的概念，Arena直译为“竞技场”的意思，每一个手势识别器（GestureRecognizer）都是一个“竞争者”（GestureArenaMember），
当发生滑动事件时，他们都要在“竞技场”去竞争本次事件的处理权，而最终只有一个“竞争者”会胜出(win)。

例如，假设有一个ListView，它的第一个子组件也是ListView，如果现在滑动这个子ListView，父ListView会动吗？答案是否定的，这时只有子ListView会动，
因为这时子ListView会胜出而获得滑动事件的处理权。
 */

///手势冲突
class GestureConflictTestRoute extends StatefulWidget {
  GestureConflictTestRoute({Key key}) : super(key: key);

  @override
  _GestureConflictTestRouteState createState() {
    return _GestureConflictTestRouteState();
  }
}

class _GestureConflictTestRouteState extends State<GestureConflictTestRoute> {
  double _left = 0.0;
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("手势冲突")),
      body: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  '当手指抬起时，onHorizontalDragEnd 和 onTapUp发生了冲突，但是因为是在拖动的语义中，所以onHorizontalDragEnd胜出，所以就会打印 “onHorizontalDragEnd”。'
                  '需要通过Listener监听原始指针事件。任何遇到复杂的冲突场景时，都可以通过Listener直接识别原始指针事件来解决冲突。'
                  '\n🌴注: 按下+滑动+抬起 的速度比较快时,不会触发 onTapDown',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
            ),

            ///手势冲突
            Positioned(
              left: _left,
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text("A"),
                  radius: 30,
                ),
                //要拖动和点击的widget
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("onHorizontalDragEnd");
                },
                onTapDown: (details) {
                  print("down");
                },
                onTapUp: (details) {
                  print("up");
                },
              ),
            ),

            ///手势冲突 Listener
            Positioned(
              top: 90.0,
              left: _leftB,
              child: Listener(
                onPointerDown: (details) {
                  print("down");
                },
                onPointerUp: (details) {
                  //会触发
                  print("up");
                },
                child: GestureDetector(
                  child: CircleAvatar(
                    child: Text("B"),
                    radius: 30,
                  ),
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    setState(() {
                      _leftB += details.delta.dx;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    print("onHorizontalDragEnd");
                  },

                  ///按下+滑动+抬起 的速度比较快时,不会触发 onTapDown
                  onTapDown: (details) {
                    print("onTapDown");
                  },
                  onTapUp: (details) {
                    print("onTapUp");
                  },
                  onPanDown: (DragDownDetails e) {
                    //打印手指按下的位置(相对于屏幕)
                    print("用户手指按下：${e.globalPosition}");
                  },
                  //手指滑动时会触发此回调
                  onPanUpdate: (DragUpdateDetails e) {
                    // setState(() {
                    //   _leftB += e.delta.dx;
                    // });
                  },
                  onPanEnd: (DragEndDetails e) {
                    //打印滑动结束时在x、y轴上的速度
                    print(e.velocity);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
