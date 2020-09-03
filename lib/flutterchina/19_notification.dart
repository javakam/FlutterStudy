import 'package:flutter/material.dart';

///Notification 👉 https://book.flutterchina.club/chapter8/notification.html
/*
通知冒泡和用户触摸事件冒泡是相似的，但有一点不同：通知冒泡可以中止，但用户触摸事件不行。

通知冒泡和Web开发中浏览器事件冒泡原理是相似的，都是事件从出发源逐层向上传递，我们可以在上层节点任意位置来监听通知/事件，也可以终止冒泡过程，终止冒泡后，通知将不会再向上传递。

eg: Flutter中很多地方使用了通知，如可滚动组件（Scrollable Widget）滑动时就会分发滚动通知（ScrollNotification），
而Scrollbar正是通过监听ScrollNotification来确定滚动条位置的。
 */

class NotificationTestRoute extends StatelessWidget {
  NotificationTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NotificationListener")),
      body: NotificationListener(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
          }
          return;
        },
        child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            }),
      ),

      ///NotificationListener 可以指定一个模板参数，该模板参数类型必须是继承自 Notification；
      ///当显式指定模板参数时，NotificationListener 便只会接收该参数类型的通知。举个例子，如果我们将上例子代码改为：
      //指定监听通知的类型为滚动结束通知 (ScrollEndNotification)
      /* NotificationListener<ScrollEndNotification>(
          onNotification: (notification){

            //只会在滚动结束时才会触发此回调
            print(notification);
          },
          child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(title: Text("$index"),);
              }
          ),
        );*/
    );
  }
}

///自定义通知
/*
Notification有一个dispatch(context)方法，它是用于分发通知的，我们说过context实际上就是操作Element的一个接口，
它与Element树上的节点是对应的，通知会从context对应的Element节点向上冒泡。
 */
class NotificationRoute extends StatefulWidget {
  @override
  _NotificationRouteState createState() {
    return new _NotificationRouteState();
  }
}

class _NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    //监听通知
    return Scaffold(
      appBar: AppBar(title: Text("自定义通知")),
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + "  ";
          });
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /*
              注意：代码中注释的部分是不能正常工作的，因为这个context是根Context，而NotificationListener是监听的子树，
              所以我们通过Builder来构建RaisedButton，来获得按钮位置的context。
               */
//          RaisedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
              Builder(
                builder: (context) {
                  return RaisedButton(
                    //按钮点击时分发通知
                    onPressed: () => MyNotification("Hi").dispatch(context),
                    child: Text("Send Notification"),
                  );
                },
              ),
              Text(_msg)
            ],
          ),
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}

///阻止冒泡
/*
class NotificationRouteState extends State<NotificationRoute> {
  String _msg="";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification){
        print(notification.msg); //打印通知
        return false;
      },
      child: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg+=notification.msg+"  ";
          });
          return false;
        },
        child: ...//省略重复代码
      ),
    );
  }
}

上列中两个NotificationListener进行了嵌套，子NotificationListener的onNotification回调返回了false，
表示不阻止冒泡，所以父NotificationListener仍然会受到通知，所以控制台会打印出通知信息；
如果将子NotificationListener的onNotification回调的返回值改为true，则父NotificationListener便不会再打印通知了，因为子NotificationListener已经终止通知冒泡了。


Context上也提供了遍历Element树的方法。
我们可以通过Element.widget得到element节点对应的widget；我们已经反复讲过Widget和Element的对应关系，读者通过这些源码来加深理解。
 */
