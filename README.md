# Flutter

- 🚀 [项目代码](https://github.com/javakam/FlutterStudy)
- 🚀 [演示代码](https://github.com/javakam/FlutterStudy/blob/master/lib/flutterchina/02_router_manage.dart)

## 一些不易理解的知识点

### 数据共享（InheritedWidget）

🌴<https://book.flutterchina.club/chapter7/willpopscope.html>

### 跨组件状态共享（Provider）
🌴<https://book.flutterchina.club/chapter7/provider.html>

### Notification 通知冒泡过程源码分析
🌴<https://book.flutterchina.club/chapter8/notification.html>

### 动画结构
演示`Dart`语言的封装技巧

🌴<https://book.flutterchina.club/chapter9/animation_structure.html>

### AnimatedSwitcher 实现原理(伪代码示例)及高级用法

🌴<https://book.flutterchina.club/chapter9/animated_switcher.html>

#### 动画过渡组件

🌴<https://book.flutterchina.club/chapter9/animated_widgets.html>

## 随记

### 获取显示的屏幕高度
用屏幕高度减去状态栏、导航栏、表头的高度即为剩余屏幕高度, 代码如下: 

```dart
... //省略无关代码
SizedBox(
  //Material设计规范中状态栏、导航栏、ListTile高度分别为24、56、56 
  height: MediaQuery.of(context).size.height-24-56-56,
  child: ListView.builder(itemBuilder: (BuildContext context, int index) {
    return ListTile(title: Text("$index"));
  }),
)
...
```

### Flutter 执行 Navigation.pop 时 重复执行一次 build 的问题

```dart
// 打开`TipRouteWithArgs`，并等待返回结果
// 路由参数 以命名路由方式传参
var result = await Navigator.pushNamed(context, page_router_test_args,
    arguments: ['abc', 23, null.toString(), "hello world"]);

//方式一 没问题
var result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) {
      return TipRouteWithArgs(
        // 路由参数 构造器方式,不推荐
        arguments: ['abc', 23, null.toString(), "hello world"],
      );
    },
    //路由参数 RouteSettings方式
    //settings: RouteSettings(),
  ),
);

//方式二 出问题
///获取路由参数 eg : ModalRoute.of(context).settings.arguments as T
class TipRouteWithArgs extends StatelessWidget {
  TipRouteWithArgs({Key key, Object arguments}) : super(key: key);
  String text = "";

  @override
  Widget build(BuildContext context) {
    print("build..........");
    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments as List<Object>;
    if (args != null && args.isNotEmpty) {
      for (var obj in args) {
        print("路由参数 : " + obj.toString());
        text += "\n ${obj.toString()}";
      }
      text = "路由参数 : \n" + text;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
```
🍎 日志结果:

```
//进入 TipRouteWithArgs
I/flutter (20504): Parent Widget build..........
I/flutter (20504): build..........
I/flutter (20504): 路由参数 : abc
I/flutter (20504): 路由参数 : 23
I/flutter (20504): 路由参数 : null
I/flutter (20504): 路由参数 : hello world

//离开 TipRouteWithArgs
I/flutter (20504): 路由返回值: 我是返回值
I/flutter (20504): build..........
I/flutter (20504): 路由参数 : abc
I/flutter (20504): 路由参数 : 23
I/flutter (20504): 路由参数 : null
I/flutter (20504): 路由参数 : hello world
```
🍎可见, 离开`TipRouteWithArgs`时又多执行了一次`build` , 
出现问题的核心代码为 `var args = ModalRoute.of(context).settings.arguments as List<Object>;`

🍉然而,官方并不认为这是个bug , `github issue` 👉 <https://github.com/flutter/flutter/issues/64133>

```
Since you've that initialized inside build() function, it's going to get called after you pop and that's why you are seeing build context being called twice.

由于在build()函数中进行了初始化，它将在弹出后被调用，这就是为什么您看到build context被调用两次。
```

🍎当然,正常思维应该是该页面退出,就不应该再执行一般`build`后在退出,不合正常逻辑。

#### 解决方式一(适用于 StatelessWidget):

```dart
var args = ModalRoute.of(context).settings.arguments as List<Object>;
//1.如果为空,返回一个轻量级的 SizedBox 控件
if (args == null || args.isEmpty) {
  return SizedBox();
}
//2.想先把args里的数据拿出来后再清空args
String text = args.name;
args.clear();
//3.使用text数据
return Scaffold(appBar: AppBar(title: Text("提示 $text"),),
...
```
再看下日志:

```
I/flutter (32061): 路由返回值: 我是返回值
I/flutter (32061): build..........
```
虽然还是会再次执行一遍`build`,但从性能角度上讲,比不优化前提高了很多。

#### 解决方式二(适用于 StatefulWidget)
> 注意: 要套上`Builder`,因为`Builder`会将`widget`节点的`context`作为回调参数,而不能用`State`的`context`!!!

```dart
String text = "";

@override
void initState() {
  super.initState();

  Builder(
    // ignore: missing_return
    builder: (context){
      //获取路由参数
      var args = ModalRoute.of(context).settings.arguments as List<Object>;
     
      text = args.name;
    },
  );
}
```
这样完美解决了退出页面时`ModalRoute.of(context).settings.arguments`造成`build`多执行一次的问题。

- 演示代码👉<https://github.com/javakam/FlutterStudy/blob/master/lib/flutterchina/02_router_manage.dart>


| 演示 | 入口 |
|:---:|:---:|
| <img src="https://raw.githubusercontent.com/javakam/FlutterStudy/master/screenshot/02_router_a.jpg" width="288" height="610"/> | <img src="https://raw.githubusercontent.com/javakam/FlutterStudy/master/screenshot/02_router_b.jpg" width="270" height="564"/> |

