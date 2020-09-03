import 'package:flutter/material.dart';

///自定义路由切换动画
///MaterialPageRoute、CupertinoPageRoute，PageRouteBuilder，它们都继承自PageRoute类
class PageAnimationTestRoute extends StatelessWidget {
  PageAnimationTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义路由动画")),
      body: Column(
        children: [
          RaisedButton(
            child: Text('PageRouteBuilder'),
            onPressed: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                  pageBuilder: (context, Animation animation, Animation secondaryAnimation) {
                    return ScaleTransition(
                      scale: animation,
                      child: _PageAnimateDestinationTest(), //路由页
                    );

                    //使用渐隐渐入过渡
                    return new FadeTransition(
                      opacity: animation,
                      child: _PageAnimateDestinationTest(), //路由页
                    );
                  },
                ),
              ),
            },
          ),
          SizedBox(
            height: 15,
          ),

          ///
          RaisedButton(
            child: Text('自定义PageRoute'),
            onPressed: () => {
              Navigator.push(context, FadeRoute(builder: (context) {
                return _PageAnimateDestinationTest();
              })),
            },
          ),
        ],
      ),
    );
  }
}

///2.自定义一个新的路由类
class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      FadeTransition(
        opacity: animation,
        child: builder(context),
      );
}

class _PageAnimateDestinationTest extends StatelessWidget {
  _PageAnimateDestinationTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("标题")),
      body: Container(
        color: Colors.blue[100],
        child: Center(
          child: Text('目标'),
        ),
      ),
    );
  }
}
