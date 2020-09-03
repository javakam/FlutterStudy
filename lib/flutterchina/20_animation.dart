import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_app/flutterchina/const.dart';

///Animation 👉 https://book.flutterchina.club/chapter9/intro.html
/*
Curves曲线
linear	    匀速的
decelerate	匀减速
ease	      开始加速，后面减速
easeIn	    开始慢，后面快
easeOut	    开始快，后面慢
easeInOut	  开始慢，然后加速，最后再减速
 */

///自定义Curve
class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(t * math.pi * 2);
  }
}

///最基础动画的实现方式
class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() => {});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //print('build...');
    return Scaffold(
      appBar: AppBar(title: Text("Animation")),
      body: new Center(
        child: Image.asset("static/images/mountain.png",
            width: animation.value, height: animation.value),
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///AnimatedWidget  简化上面的方式
/*
用AnimatedBuilder重构, AnimatedBuilder为AnimatedWidget的子类

用AnimatedWidget可以从动画中分离出widget，而动画的渲染过程（即设置宽高）仍然在AnimatedWidget中，假设如果我们再添加一个widget透明度变化的动画，
那么我们需要再实现一个AnimatedWidget，这样不是很优雅，如果我们能把渲染过程也抽象出来，那就会好很多，而AnimatedBuilder正是将渲染逻辑分离出来,

上面的build方法中的代码可以改为：
 */

class _AnimatedImage extends AnimatedWidget {
  _AnimatedImage({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset("static/images/mountain.png",
          width: animation.value, height: animation.value),
    );
  }
}

class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState1 createState() => new _ScaleAnimationRouteState1();
}

class _ScaleAnimationRouteState1 extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedWidget/AnimatedBuilder")),
      //body: _AnimatedImage(animation: animation,),

      ///用AnimatedBuilder重构
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'AnimatedBuilder三个优点: \n1.不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。\n\n'
                '2.动画构建的范围缩小了，如果没有builder，setState()将会在父组件上下文中调用，这将会导致父组件的build方法重新调用；'
                '而有了builder之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。\n\n'
                '3.通过AnimatedBuilder可以封装常见的过渡效果来复用动画。',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animation,
            child: Image.asset("static/images/mountain.png"),
            builder: (BuildContext ctx, Widget child) {
              return new Center(
                child: Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///3.通过AnimatedBuilder可以封装常见的过渡效果来复用动画。
///下面我们通过封装一个GrowTransition来说明，它可以对子widget实现放大动画：
class _GrowTransition extends StatelessWidget {
  _GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}

class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState2 createState() => new _ScaleAnimationRouteState2();
}

class _ScaleAnimationRouteState2 extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);

    //在动画正向执行结束时反转动画，在动画反向执行结束时再正向执行动画
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画（正向）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GrowTransition、动画状态监听')),
      body: Column(
        children: [
          Text(
            '动画状态监听(addStatusListener): 在动画正向执行结束时反转动画，在动画反向执行结束时再正向执行动画',
            style: TextStyle(fontSize: 15, color: Colors.grey,fontFamily: fontAliPuHui),
          ),
          _GrowTransition(
            child: Image.asset("static/images/mountain.png"),
            animation: animation,
          ),
        ],
      ),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///动画状态监听
/*
dismissed	  动画在起始点停止
forward	    动画正在正向执行
reverse	    动画正在反向执行
completed	  动画在终点停止
 */

///示例: 在动画正向执行结束时反转动画，在动画反向执行结束时再正向执行动画
/*
initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画（正向）
    controller.forward();
  }
 */
