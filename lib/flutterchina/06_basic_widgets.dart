import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/MyIcons.dart';
import 'package:flutter_app/flutterchina/utils.dart';
import 'package:flutter_app/flutterchina/const.dart';

///
/// 基础组件
/// 包括: Switch/Checkbox/TextField/Form/LinearProgressIndicator/CircularProgressIndicator/Image/Icon
/// @author javakam
///
class BasicWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widgets'),
      ),
      body: Container(
          child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(3.0),
        children: [
          ///Text
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

          Text('--------------自定义字体-----------'),
          // 使用文本样式
          Text(
            "Alibaba PuHuiTi: 使用此文本的字体(Use the font for this text)",
            style: TextStyle(fontFamily: fontAliPuHui),
          ),
          Text(
            "iconfont:使用此文本的字体(Use the font for this text)",
            style: TextStyle(fontFamily: fontIconFontCN),
          ),
          Text(
            "google_kavivanar:使用此文本的字体(Use the font for this text)",
            style: TextStyle(fontFamily: fontGoogleKavivanar),
          ),
          Text('---------------------------------'),

          /// OutlineButton/IconButton/RaisedButton/FlatButton.icon/FlatButton
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

          ///单选开关和复选框 Switch/Checkbox
          _SwitchAndCheckBoxTestRoute(),
          _CheckboxTestWidget(),

          ///TextField
          //登录输入框
          Text(
            '🌴输入框 TextField 👉',
            style: TextStyle(
              fontFamily: fontAliPuHui,
              fontWeight: FontWeight.bold,
            ),
          ),
          _TextFieldTestWidget(),
          SizedBox(
            height: 10,
          ),

          Text(
            '🌴控制焦点 TextField 👉 \n' +
                '  ·点击第一个按钮可以将焦点从第一个TextField挪到第二个TextField。\n  ·点击第二个按钮可以关闭键盘。',
            style: TextStyle(fontFamily: fontAliPuHui, fontWeight: FontWeight.bold, fontSize: 11),
          ),

          _TextFieldFocusTestRoute(),

          //Form
          SizedBox(
            height: 50,
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                FlatButton(
                  child: Text(
                    '🌴表单 Form 👉 Open Page ! ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: fontAliPuHui,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.lightBlueAccent[100],
                  onPressed: () {
                    Navigator.of(context).pushNamed(page_widget_form);
                  },
                ),
              ],
            ),
          ),

          /// 进度指示器
          Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🌴进度指示器 👉 \n',
                  style: TextStyle(
                    fontFamily: fontAliPuHui,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 模糊进度条(会执行一个动画)
                LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),
                //进度条显示50%
                LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
                SizedBox(
                  height: 10,
                ),

                // 模糊进度条(会执行一个旋转动画)
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),
                //进度条显示50%，会显示一个半圆
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '🌴自定义进度指示器 👉 \n',
                  style: TextStyle(
                    fontFamily: fontAliPuHui,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 线性进度条高度指定为3
                SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: .5,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // 圆形进度条直径指定为100
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: .7,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // 注意，如果CircularProgressIndicator显示空间的宽高不同，则会显示为椭圆。如：
                // 宽高不等
                SizedBox(
                  height: 100,
                  width: 130,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: .7,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //进度色动画: 进度条在3秒内从灰色变成蓝色的动画
                _ProgressRoute(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          ///Image
          /*
          const Image({
            ...
            this.width, //图片的宽
            this.height, //图片高度
            this.color, //图片的混合色值
            this.colorBlendMode, //混合模式
            this.fit,//缩放模式
            this.alignment = Alignment.center, //对齐方式
            this.repeat = ImageRepeat.noRepeat, //重复方式
          })
           */
          Text(
            '🌴从assets加载图片 👉',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),
          Image(image: AssetImage("static/images/landscape.png"), width: 60.0, height: 60.0),

          Image.asset(
            "static/images/landscape.png",
            width: 60.0,
            height: 60.0,
          ),
          Text(
            '🌴从网络加载图片 👉',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),
          Image(
            image: NetworkImage("https://www.easyicon.net/api/resizeApi.php?id=1228952&size=72"),
            width: 60.0,
            height: 60.0,
          ),
          Image.network(
            "https://www.easyicon.net/api/resizeApi.php?id=1228952&size=72",
            width: 100.0,
            height: 60.0,
          ),

          ///圆角图片
          Text(
            '🌴圆角图片 👉',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),
          Column(
            children: [
              Image(
                image: NetworkImage(
                    "https://portrait.gitee.com/uploads/avatars/user/168/505050_javakam_1599631074.png"),
                width: 60.0,
                height: 60.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent[50],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://portrait.gitee.com/uploads/avatars/user/168/505050_javakam_1599631074.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    // placeholder: (context, url) => placeholder,
                    // errorWidget: (context, url, error) => placeholder,
                  ),
                ),
              ),
              ListTile(
                dense: true,
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://portrait.gitee.com/uploads/avatars/user/168/505050_javakam_1599631074.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Text(
            '🌴图片缩放模式 fit 👉',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),

          _ImageAndIconRoute(),
          Text(
            '🌴图片缩放模式 fit 其他效果 👉',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),
          Image.network(
            "https://pcdn.flutterchina.club/imgs/3-18.png",
            fit: BoxFit.fill,
          ),

          //- color 和 colorBlendMode：在图片绘制时可以对每一个像素进行颜色混合处理，
          //color指定混合色，而 colorBlendMode 指定混合模式:
          //- repeat：当图片本身大小小于显示空间时，指定图片的重复规则。
          Image.network(
            "https://www.easyicon.net/api/resizeApi.php?id=1228952&size=72",
            width: 80.0,
            height: 150.0,
            color: Colors.blue,
            colorBlendMode: BlendMode.difference,
            repeat: ImageRepeat.repeatY,
          ),
          Text(
            '🌴Image缓存 \n ' +
                'Flutter框架对加载过的图片是有缓存的（内存），默认最大缓存数量是1000，最大缓存空间为100M。关于Image的详细内容及原理我们将会在后面进阶部分深入介绍。\n',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),

          ///Icon
          _IconsRoute(),
        ],
      )),
    );
  }
}

class _ProgressRoute extends StatefulWidget {
  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<_ProgressRoute> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    //动画执行时间3秒
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              // 从灰色变成蓝色
              valueColor:
                  ColorTween(begin: Colors.grey, end: Colors.blue).animate(_animationController),
              value: _animationController.value,
            ),
          ),
        ],
      ),
    );
  }
}

///控制焦点  TextField
class _TextFieldFocusTestRoute extends StatefulWidget {
  @override
  _TextFieldFocusTestRouteState createState() => new _TextFieldFocusTestRouteState();
}

class _TextFieldFocusTestRouteState extends State<_TextFieldFocusTestRoute> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();
    // 监听焦点变化
    focusNode1.addListener(() {
      toastTop("焦点变化 : input1=${focusNode1.hasFocus}  input2=${focusNode2.hasFocus}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: false,
            focusNode: focusNode1, //关联focusNode1
            decoration: InputDecoration(labelText: "input1"),
          ),
          TextField(
            focusNode: focusNode2, //关联focusNode2
            decoration: InputDecoration(labelText: "input2"),
          ),
          Builder(
            builder: (ctx) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      //将焦点从第一个TextField移到第二个TextField
                      // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                      // 这是第二种写法
                      if (null == focusScopeNode) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode.requestFocus(focusNode2);
                    },
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      // 当所有编辑框都失去焦点时键盘就会收起
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

///登录输入框 TextField
///
/// 光标移入时,触发一次 TextEditingController.Listener 回调
/// I/flutter ( 4181): _controller:
/// I/flutter ( 4181): _controller: 看监控
/// I/flutter ( 4181): onChange: 看监控
///
class _TextFieldTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TextFieldTestWidgetState();
}

class _TextFieldTestWidgetState extends State<_TextFieldTestWidget> {
  TextEditingController _controller = TextEditingController();

  //下划线颜色随焦点改变而改变
  FocusNode _focusNode = FocusNode();
  bool _isCustomTextFieldFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isCustomTextFieldFocus = !_isCustomTextFieldFocus;
        print("_isCustomTextFieldFocus = $_isCustomTextFieldFocus");
      });
    });

    //设置默认值，并从第三个字符开始选中后面的字符
    _controller.text = "hello world!";
    _controller.selection = TextSelection(baseOffset: 2, extentOffset: _controller.text.length);
    _controller.addListener(() {
      print("_controller: " + _controller.text);
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          //Card 做圆角效果
          Card(
            elevation: 3,
            shadowColor: Colors.pinkAccent[100],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                child: TextField(
                  autofocus: false, //true 进入页面直接弹出软键盘
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.purple, fontSize: 13.0),
                    labelText: "自定义样式的输入框 ○",
                    hintText: "自定义样式 hintText",
                    prefixIcon: Icon(
                      MyIcons.wechat,
                      color: Colors.green,
                    ),
                    border: InputBorder.none, //隐藏下划线
                  ),
                ),
                decoration: BoxDecoration(
                    border: _isCustomTextFieldFocus
                        ? Border(bottom: BorderSide(color: Colors.limeAccent[400], width: 2))
                        : Border(bottom: BorderSide(color: Colors.grey[200], width: 2))),
              ),
            ),
          ),

          TextField(
            controller: _controller,
            onChanged: (value) {
              print("onChange: $value");
            },
            autofocus: false, //true 进入页面直接弹出软键盘
            decoration: InputDecoration(
                labelText: "用户名", hintText: "用户名或邮箱", prefixIcon: Icon(Icons.person)),
          ),
          TextField(
            decoration:
                InputDecoration(labelText: "密码", hintText: "您的登录密码", prefixIcon: Icon(Icons.lock)),
            obscureText: true,
          ),
        ],
      );
}

///单选开关和复选框  Switch/Checkbox
class _SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRouteState createState() => new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState extends State<_SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = false; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected, //当前状态
          onChanged: (value) {
            //重新构建页面
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        )
      ],
    );
  }
}

class _CheckboxTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckBoxTestState();
  }
}

class _CheckBoxTestState extends State {
  bool _isMale;
  bool _isFemale;
  bool _checkboxListChecked;
  bool _checkboxList2Checked;

  @override
  void initState() {
    super.initState();
    _isMale = true;
    _isFemale = false;
    _checkboxListChecked = false;
    _checkboxList2Checked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("\n🌴Checkbox", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Row(
              children: <Widget>[
                Text("男"),
                Checkbox(
                  value: _isMale,
                  onChanged: (isMan) {
                    setState(() {
                      if (isMan) {
                        _isMale = true;
                        _isFemale = false;
                      }
                    });
                  },
                )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              children: <Widget>[
                Text("女"),
                Checkbox(
                  value: _isFemale,
                  onChanged: (isFemale) {
                    setState(() {
                      if (isFemale) {
                        _isFemale = true;
                        _isMale = false;
                      }
                    });
                  },
                )
              ],
            )
          ],
        ),
        Text("\n🌴CheckboxListTile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(
            width: 250,
            child: Column(
              children: <Widget>[
                CheckboxListTile(
                  // 必须要的属性
                  value: _checkboxListChecked,
                  onChanged: (isCheck) {
                    toast("选的$isCheck");
                    setState(() {
                      _checkboxListChecked = isCheck;
                    });
                  },
                  // 选中时 checkbox 的填充的颜色
                  activeColor: Colors.red,
                  title: Text(
                    "标题 title",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  subtitle: Text("副标题 subtitle"),
                  // 是否是三行文本
                  // 如果是 true ： 副标题 不能为 null
                  // 如果是 false：
                  // 如果没有副标题 ，就只有一行， 如果有副标题 ，就只有两行
                  isThreeLine: true,
                  // 是否密集垂直
                  dense: false,
                  // 左边的一个控件
                  secondary: Icon(
                    Icons.account_balance,
                    color: Colors.lightGreen,
                  ),
                  // text 和 icon 的 color 是否 是 activeColor 的颜色
                  selected: false,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                CheckboxListTile(
                  onChanged: (isCheck) {
                    setState(() {
                      _checkboxList2Checked = isCheck;
                    });
                  },
                  selected: false,
                  value: _checkboxList2Checked,
                  title: Text("标题2-翻转文字和选项框leading"),
                  controlAffinity: ListTileControlAffinity.leading,
                )
              ],
            )),
      ],
    );
  }
}

class _IconsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String icons = "";
    // accessible: &#xE914; or 0xE914 or E914
    icons += "\uE914";
    // error: &#xE000; or 0xE000 or E000
    icons += " \uE000";
    // fingerprint: &#xE90D; or 0xE90D or E90D
    icons += " \uE90D";
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌴Text + MaterialIcons',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                icons,
                style: TextStyle(fontFamily: "MaterialIcons", fontSize: 24.0, color: Colors.green),
              ),
            ],
          ),
          /*
          通过这个示例可以看到，使用图标就像使用文本一样，但是这种方式需要我们提供每个图标的码点，这并对开发者不友好，
          所以，Flutter封装了 IconData 和 Icon 来专门显示字体图标，上面的例子也可以用如下方式实现：
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.android,
                color: Colors.green,
              ),
              Icon(
                Icons.error,
                color: Colors.green,
              ),
              Icon(
                Icons.fingerprint,
                color: Colors.green,
              ),
            ],
          ),
          Text(
            '\n🌴使用自定义字体图标',
            style: TextStyle(fontFamily: fontAliPuHui),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                MyIcons.book,
                color: Colors.purple,
              ),
              Icon(
                MyIcons.wechat,
                color: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ImageAndIconRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = AssetImage("static/images/landscape.png");
    return SingleChildScrollView(
      child: Column(
          children: <Image>[
        Image(
          image: img,
          height: 50.0,
          width: 100.0,
          fit: BoxFit.fill,
        ),
        Image(
          image: img,
          height: 50,
          width: 50.0,
          fit: BoxFit.contain,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.fitWidth,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.fitHeight,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 50.0,
          fit: BoxFit.scaleDown,
        ),
        Image(
          image: img,
          height: 50.0,
          width: 100.0,
          fit: BoxFit.none,
        ),
        Image(
          image: img,
          width: 100.0,
          color: Colors.blue,
          colorBlendMode: BlendMode.difference,
          fit: BoxFit.fill,
        ),
        Image(
          image: img,
          width: 100.0,
          height: 200.0,
          repeat: ImageRepeat.repeatY,
        )
      ].map((e) {
        return Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 100,
                child: e,
              ),
            ),
            Text(e.fit.toString())
          ],
        );
      }).toList()),
    );
  }
}

///BoxDecoration
class BoxDecorationTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BoxDecoration'),
      ),
      body: Container(
          //四周10大小的maring
          margin: EdgeInsets.all(10.0),
          height: 120.0,
          width: 500.0,
          //透明黑色遮罩
          decoration: BoxDecoration(
              //弧度为4.0
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //设置了decoration的color，就不能设置Container的color。
              color: Colors.teal,
              //边框
              border: new Border.all(color: Colors.red, width: 2.3)),
          child: new Text("666666")),
    );
  }
}

///Column + Expanded
class ExpandedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column Expanded'),
      ),
      body: new Column(
        verticalDirection: VerticalDirection.up,
        //主轴居中,即是竖直向居中
        mainAxisAlignment: MainAxisAlignment.center,
        //大小按照最小显示
        mainAxisSize: MainAxisSize.min,
        //横向也居中
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //flex默认为1
          new Expanded(
            child: new Text("1111"),
            flex: 2,
          ),
          new Expanded(child: new Text("2222")),
          new Expanded(child: new Text("3333")),
          new Expanded(child: new Text("4444")),
          new Expanded(child: new Text("5555")),
        ],
      ),
    );
  }
}
