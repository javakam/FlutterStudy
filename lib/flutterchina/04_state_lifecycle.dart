import 'package:flutter/material.dart';

///
/// 图 👉 https://pcdn.flutterchina.club/imgs/3-2.jpg
/// 结果:
/// I/flutter ( 6734): initState
/// I/flutter ( 6734): didChangeDependencies
/// I/flutter ( 6734): build
///
/// 点击⚡️按钮热重载，控制台输出日志如下：
/// I/flutter ( 8231): reassemble
/// I/flutter ( 8231): didUpdateWidget
/// I/flutter ( 8231): build
///
/// 每点一次数字按钮,执行一次 I/flutter ( 8231): build
///
/// I/flutter ( 6734): deactivate
/// I/flutter ( 6734): dispose
///
class StateLifecycleCounterWidget extends StatefulWidget {
  const StateLifecycleCounterWidget({Key key, this.initValue: 0});

  final int initValue;

  @override
  _StateLifecycleCounterWidgetState createState() => new _StateLifecycleCounterWidgetState();
}

class _StateLifecycleCounterWidgetState extends State<StateLifecycleCounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.initValue;
    print("initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didUpdateWidget(StateLifecycleCounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          color: Colors.greenAccent,
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed: () => setState(
            () => ++_counter,
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }
}
