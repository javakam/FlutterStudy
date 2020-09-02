import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/const.dart';

///使用对话框 showDialog
class AlertDialogRoute extends StatelessWidget {
  AlertDialogRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dialog")),
      body: Column(
        children: [
          ///AlertDialog
          //点击该按钮后弹出对话框
          RaisedButton(
            child: Text("AlertDialog"),
            onPressed: () async {
              //弹出对话框并等待其关闭
              bool delete = await showDeleteConfirmDialog1(context);
              if (delete == null) {
                print("取消删除");
              } else {
                print("已确认删除");
                //... 删除文件
              }
            },
          ),

          ///SimpleDialog
          RaisedButton(
            child: Text("SimpleDialog"),
            onPressed: () async {
              changeLanguage(context);
            },
          ),

          ///Dialog+ListView/GridView/CustomScrollView
          RaisedButton(
            child: Text("Dialog+ListView/GridView/CustomScrollView"),
            onPressed: () async {
              showListDialog(context);
            },
          ),

          ///自定义外部样式的Dialog👉showGeneralDialog
          RaisedButton(
            child: Text("自定义外部样式的Dialog👉showGeneralDialog"),
            onPressed: () async {
              showCustomDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("提示"),
                    content: Text("您确定要删除当前文件吗?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("取消"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text("删除"),
                        onPressed: () {
                          Navigator.of(context).pop(true); // 执行删除操作
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

          ///对话框状态管理
          RaisedButton(
            child: Text("状态管理👉使用StatefulBuilder来构建StatefulWidget上下文"),
            onPressed: () async {
              showDeleteConfirmDialog3(context);
            },
          ),

          ///对话框状态管理
          RaisedButton(
            child: Text("状态管理👉(context as Element).markNeedsBuild()"),
            onPressed: () async {
              showDeleteConfirmDialog4(context);
            },
          ),

          RaisedButton(
            child: Text("显示底部菜单列表👉showModalBottomSheet"),
            onPressed: () async {
              int type = await _showModalBottomSheet(context);
              print(type);
            },
          ),

          Builder(builder: (context) {
            return RaisedButton(
              child: Text(
                "显示底部菜单列表(全屏)👉showBottomSheet \n"
                "🌴调用showBottomSheet方法就必须得保证父级组件中有Scaffold",
                style: TextStyle(fontSize: 14),
              ),
              onPressed: () {
                _showBottomSheet(context);
              },
            );
          }),

          RaisedButton(
            child: Text("Loading加载框👉showDialog+AlertDialog"),
            onPressed: () {
              _showLoadingDialog(context);
            },
          ),

          RaisedButton(
            child: Text("日历👉showDatePicker"),
            onPressed: () {
              _showDatePicker1(context);
            },
          ),

          RaisedButton(
            child: Text("日历(IOS风格)👉showCupertinoModalPopup+CupertinoDatePicker"),
            onPressed: () {
              _showDatePicker2(context);
            },
          ),
        ],
      ),
    );
  }
}

///AlertDialog
/*
const AlertDialog({
  Key key,
  this.title, //对话框标题组件
  this.titlePadding, // 标题填充
  this.titleTextStyle, //标题文本样式
  this.content, // 对话框内容组件
  this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0), //内容的填充
  this.contentTextStyle,// 内容文本样式
  this.actions, // 对话框操作按钮组
  this.backgroundColor, // 对话框背景色
  this.elevation,// 对话框的阴影
  this.semanticLabel, //对话框语义化标签(用于读屏软件)
  this.shape, // 对话框外形
})

我们通过Navigator.of(context).pop(result)返回的result值

注意：如果AlertDialog的内容过长，内容将会溢出，这在很多时候可能不是我们期望的，所以如果对话框内容过长时，可以用SingleChildScrollView将内容包裹起来。
 */
Future<bool> showDeleteConfirmDialog1(context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, //点击对话框barrier(遮罩)时是否关闭它
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text("您确定要删除当前文件吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              //关闭对话框并返回true
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

///SimpleDialog
Future<void> changeLanguage(context) async {
  int i = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // 返回1
                Navigator.pop(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('中文简体'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('美国英语'),
              ),
            ),
          ],
        );
      });

  if (i != null) {
    print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
  }
}

/*
实际上AlertDialog和SimpleDialog都使用了Dialog类。由于AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，
这就导致他们的子组件不能是延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等），如下面的代码运行后会报错。
 */

///直接使用 Dialog
Future<void> showListDialog(context) async {
  int index = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      var child = Column(
        children: <Widget>[
          ListTile(title: Text("请选择")),
          Expanded(
              child: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          )),
        ],
      );
      //使用AlertDialog会报错
      //return AlertDialog(content: child);
      ///
      //return Dialog(child: child);
      ///也可以用下面的方式替换:
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 280),
          child: Material(
            child: child,
            type: MaterialType.card,
          ),
        ),
      );
    },
  );
  if (index != null) {
    print("点击了：$index");
  }
}

///自定义外部样式的Dialog👉showGeneralDialog
/*
非Material风格的Dialog

Future<T> showGeneralDialog<T>({
  @required BuildContext context,
  @required RoutePageBuilder pageBuilder, //构建对话框内部UI
  bool barrierDismissible, //点击遮罩是否关闭对话框
  String barrierLabel, // 语义化标签(用于读屏软件)
  Color barrierColor, // 遮罩颜色
  Duration transitionDuration, // 对话框打开/关闭的动画时长
  RouteTransitionsBuilder transitionBuilder, // 对话框打开/关闭的动画
})
 */
Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.red[50],
    // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

///使用StatefulBuilder来构建StatefulWidget上下文
Future<bool> showDeleteConfirmDialog3(context) {
  bool _withTree = false;
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("您确定要删除当前文件吗?"),
            Row(
              children: <Widget>[
                Text("同时删除子目录？"),

                ///使用StatefulBuilder来构建StatefulWidget上下文
                StatefulBuilder(
                  builder: (context, _setState) {
                    return Checkbox(
                      value: _withTree, //默认不选中
                      onChanged: (bool value) {
                        //_setState方法实际就是该StatefulWidget的setState方法，
                        //调用后builder方法会重新被调用
                        _setState(() {
                          //更新选中状态
                          _withTree = !_withTree;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              // 执行删除操作
              Navigator.of(context).pop(_withTree);
            },
          ),
        ],
      );
    },
  );
}

///(context as Element).markNeedsBuild();
/*
void setState(VoidCallback fn) {
  ... //省略无关代码
  _element.markNeedsBuild();
}
可以发现，setState中调用了Element的markNeedsBuild()方法，我们前面说过，Flutter是一个响应式框架，要更新UI只需改变状态后通知框架页面需要重构即可，
而Element的markNeedsBuild()方法正是来实现这个功能的！markNeedsBuild()方法会将当前的Element对象标记为“dirty”（脏的），
在每一个Frame，Flutter都会重新构建被标记为“dirty”Element对象。既然如此，我们有没有办法获取到对话框内部UI的Element对象，然后将其标示为为“dirty”呢？答案是肯定的！

我们可以通过Context来得到Element对象，至于Element与Context的关系我们将会在后面“Flutter核心原理”一章中再深入介绍，
现在只需要简单的认为：在组件树中，context实际上就是Element对象的引用。知道这个后，那么解决的方案就呼之欲出了，我们可以通过如下方式来让复选框可以更新：
 */
Future<bool> showDeleteConfirmDialog4(context) {
  bool _withTree = false;
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("您确定要删除当前文件吗?"),
            Row(
              children: <Widget>[
                Text("同时删除子目录？"),
                // 通过Builder来获得构建Checkbox的`context`，
                // 这是一种常用的缩小`context`范围的方式
                Builder(
                  builder: (BuildContext context) {
                    // 依然使用Checkbox组件
                    return Checkbox(
                      value: _withTree,
                      onChanged: (bool value) {
                        // 此时context为对话框UI的根Element，我们
                        // 直接将对话框UI对应的Element标记为dirty
                        (context as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              // 执行删除操作
              Navigator.of(context).pop(_withTree);
            },
          ),
        ],
      );
    },
  );
}

// 弹出底部菜单列表模态对话框
Future<int> _showModalBottomSheet(context) {
  return showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
            onTap: () => Navigator.of(context).pop(index),
          );
        },
      );
    },
  );
}

// 返回的是一个controller
PersistentBottomSheetController<int> _showBottomSheet(context) {
  return showBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
            onTap: () {
              // do something
              print("$index");
              Navigator.of(context).pop();
            },
          );
        },
      );
    },
  );
}

///Loading加载框👉showDialog+AlertDialog
_showLoadingDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: true, //点击遮罩不关闭对话框
    builder: (context) {
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: SizedBox(
          height: 520,
          width: 260,
          child: AlertDialog(
            elevation: 3,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //CircularProgressIndicator(value: .8,),
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "正在加载，请稍后...",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: fontAliPuHui,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

///日历 showDatePicker
Future<DateTime> _showDatePicker1(context) {
  var date = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: date,
    firstDate: date,
    lastDate: date.add(
      //未来30天可选
      Duration(days: 30),
    ),
  );
}

///日历 iOS风格的日历选择器需要使用showCupertinoModalPopup方法和CupertinoDatePicker组件来实现：
Future<DateTime> _showDatePicker2(context) {
  var date = DateTime.now();
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: date,
          maximumDate: date.add(
            Duration(days: 30),
          ),
          maximumYear: date.year + 1,
          onDateTimeChanged: (DateTime value) {
            print(value);
          },
        ),
      );
    },
  );
}
