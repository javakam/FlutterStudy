import 'package:flutter/material.dart';

/*
Listener({
  Key key,
  this.onPointerDown, //手指按下回调
  this.onPointerMove, //手指移动回调
  this.onPointerUp,//手指抬起回调
  this.onPointerCancel,//触摸事件取消回调
  this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现
  Widget child
})
 */
class ListenerTestRoute extends StatefulWidget {
  ListenerTestRoute({Key key}) : super(key: key);

  @override
  _ListenerTestRouteState createState() {
    return _ListenerTestRouteState();
  }
}

class _ListenerTestRouteState extends State<ListenerTestRoute> {
  ///定义一个状态，保存当前指针位置
  /*
  PointerEvent类中包括当前指针的一些信息，如：
      position：它是鼠标相对于当对于全局坐标的偏移。
      delta：两次指针移动事件（PointerMoveEvent）的距离。
      pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
      orientation：指针移动方向，是一个角度值。
      ...
   */
  PointerEvent _event;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build....');
    return Scaffold(
      appBar: AppBar(title: Text("Listener")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///behavior: HitTestBehavior.deferToChild
          Listener(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 300.0,
              height: 90.0,
              child: Text(_event?.toString() ?? "", style: TextStyle(color: Colors.white)),
            ),
            //behavior: HitTestBehavior.opaque,
            onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
            onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
            onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
          ),
          SizedBox(
            height: 15,
          ),

          ///behavior: HitTestBehavior.opaque
          ///注意，该属性并不能用于在组件树中拦截（忽略）事件，它只是决定命中测试时的组件大小。
          Text('🌴behavior: HitTestBehavior.opaque'),
          Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300.0, 80.0)),
                child: Center(child: Text("Box A")),
              ),
              //behavior: HitTestBehavior.opaque,
              onPointerDown: (event) => print("down A")),
          SizedBox(
            height: 15,
          ),

          ///behavior: HitTestBehavior.translucent,
          Text('🌴behavior: HitTestBehavior.translucent'),
          Stack(
            children: <Widget>[
              Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(300.0, 100.0)),
                  child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
                ),
                onPointerDown: (event) => print("down0"),
              ),
              Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 80.0)),
                  child: Center(child: Text("左上角200*100范围内非文本区域点击")),
                ),
                onPointerDown: (event) => print("down1"),
                behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),

          ///忽略PointerEvent
          /*
          假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，
          这两个组件都能阻止子树接收指针事件，不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，
          这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以。

         点击Container时，由于它在AbsorbPointer的子树上，所以不会响应指针事件，所以日志不会输出"in"，
         但AbsorbPointer本身是可以接收指针事件的，所以会输出"down"。如果将 AbsorbPointer 换成 IgnorePointer，那么两个都不会输出。
           */
          Listener(
            child: AbsorbPointer(
              //AbsorbPointer IgnorePointer
              child: Listener(
                child: Container(
                  color: Colors.red,
                  width: 200.0,
                  height: 100.0,
                ),
                onPointerDown: (event) => print("in"),
              ),
            ),
            onPointerDown: (event) => print("down"),
          ),
        ],
      ),
    );
  }
}
