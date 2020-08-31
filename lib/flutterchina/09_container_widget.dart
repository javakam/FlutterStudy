import 'package:flutter/material.dart';
import 'dart:math' as math;

///Padding/ConstrainedBox/UnconstrainedBox/多重限制/DecoratedBox/AspectRatio/LimitedBox/FractionallySizedBox
class ContainerTestWidget extends StatelessWidget {
  ContainerTestWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '布局 Container',
          style: TextStyle(
            fontSize: 15,
          ),
        ),

        ///UnconstrainedBox
        actions: <Widget>[
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            ///BoxConstraints用于设置限制条件
            /*
            const BoxConstraints({
              this.minWidth = 0.0, //最小宽度
              this.maxWidth = double.infinity, //最大宽度
              this.minHeight = 0.0, //最小高度
              this.maxHeight = double.infinity //最大高度
            })
            */
            constraints: BoxConstraints(
              minWidth: double.infinity, //宽度尽可能大
              minHeight: 30.0, //最小高度为50像素
            ),
            child: Container(height: 5.0, child: redBox),
          ),
          SizedBox(
            height: 10,
          ),

          ///SizedBox用于给子元素指定固定的宽高，如：
          SizedBox(width: 30.0, height: 30.0, child: redBox),
          /*
          实际上SizedBox只是ConstrainedBox的一个定制，上面代码等价于：
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 80.0,height: 80.0),
            child: redBox,
          )

          而实际上ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的，
          我们可以看到ConstrainedBox和SizedBox的createRenderObject()方法都返回的是一个 RenderConstrainedBox 对象
           */
          SizedBox(
            height: 10,
          ),

          ///
          ConstrainedBox(
            constraints: BoxConstraints.tightForFinite(width: 80, height: 80),
            child: redBox,
          ),
          SizedBox(
            height: 10,
          ),

          ///多重限制
          Text(
            "存在有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。"
            "对于maxWidth和maxHeight来说，是取父子中相应数值小的。"
            "实际上，只有这样才能保证父限制与子限制不冲突。\n",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ///minWidth/minHeight 都是 (90,60) -> 对于minWidth和minHeight来说，是取父子中相应数值较大的。
          // ConstrainedBox(
          //     constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
          //     child: ConstrainedBox(
          //       constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
          //       child: redBox,
          //     )),
          // SizedBox(
          //   height: 10,
          // ),
          // ConstrainedBox(
          //     constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
          //     child: ConstrainedBox(
          //       constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
          //       child: redBox,
          //     )),
          // SizedBox(
          //   height: 10,
          // ),

          ///maxWidth/maxHeight 都是 (60,20)  -> 对于maxWidth和maxHeight来说，是取父子中相应数值小的。
          // SizedBox(
          //   width: 90,
          //   height: 60,
          //   child: redBox,
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // ConstrainedBox(
          //     constraints: BoxConstraints(maxWidth: 60.0, maxHeight: 60.0), //父
          //     child: ConstrainedBox(
          //       constraints: BoxConstraints(maxWidth: 90.0, maxHeight: 20.0), //子
          //       child: Container(width: 60, height: 20.0, child: redBox),
          //     )),
          // SizedBox(
          //   height: 10,
          // ),
          // ConstrainedBox(
          //     constraints: BoxConstraints(maxWidth: 90.0, maxHeight: 20.0),
          //     child: ConstrainedBox(
          //       constraints: BoxConstraints(maxWidth: 60.0, maxHeight: 60.0),
          //       child: Container(width: 120, height: 30.0, child: redBox),
          //     )),
          // SizedBox(
          //   height: 10,
          // ),

          ///BoxDecoration
          /*
          BoxDecoration({
            Color color, //颜色
            DecorationImage image,//图片
            BoxBorder border, //边框
            BorderRadiusGeometry borderRadius, //圆角
            List<BoxShadow> boxShadow, //阴影,可以指定多个
            Gradient gradient, //渐变
            BlendMode backgroundBlendMode, //背景混合模式
            BoxShape shape = BoxShape.rectangle, //形状
          })
           */

          SizedBox(
            height: 10,
          ),
          DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]), //背景渐变
                  borderRadius: BorderRadius.circular(3.0), //3像素圆角
                  boxShadow: [
                    //阴影
                    BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}

///Transform/RotatedBox/Container
class TransformTestWidget extends StatelessWidget {
  TransformTestWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '布局 Container',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(45, 45, 0, 15),
            child: Container(
              color: Colors.black,
              child: new Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('Apartment for rent!'),
                ),
              ),
            ),
          ),

          ///平移
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            //默认原点为左上角，左移20像素，向上平移5像素
            child: Transform.translate(
              offset: Offset(-20.0, -5.0),
              child: Text("Hello world"),
            ),
          ),
          SizedBox(
            height: 45,
          ),

          ///旋转
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              //旋转90度
              angle: math.pi / 2,
              child: Text("Hello world"),
            ),
          ),
          SizedBox(
            height: 45,
          ),

          ///缩放
          DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.scale(
                  scale: 1.5, //放大到1.5倍
                  child: Text("Hello world"))),
          SizedBox(
            height: 10,
          ),

          ///注意: Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子组件应用何种变化，
          ///其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
          /*
          由于矩阵变化只会作用在绘制阶段，所以在某些场景下，在UI需要变化时，可以直接通过矩阵变化来达到视觉上的UI改变，
          而不需要去重新触发build流程，这样会节省layout的开销，所以性能会比较好。
          如之前介绍的Flow组件，它内部就是用矩阵变换来更新UI，除此之外，Flutter的动画组件中也大量使用了Transform以提高性能。
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.scale(scale: 1.5, child: Text("Hello world"))),
              Text(
                "你好",
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),

          ///思考题：使用Transform对其子组件先进行平移然后再旋转和先旋转再平移，两者最终的效果一样吗？为什么？
          //todo 2020年8月31日 16:20:19

          ///RotatedBox和Transform.rotate功能相似，它们都可以对子组件进行旋转变换，
          ///但是有一点不同：RotatedBox的变换是在layout阶段，会影响在子组件的位置和大小。
          ///我们将上面介绍Transform.rotate时的示例改一下
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                //将Transform.rotate换成RotatedBox
                child: RotatedBox(
                  quarterTurns: 1, //旋转90度(1/4圈)
                  child: Text("Hello world"),
                ),
              ),
              Text(
                "你好",
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              )
            ],
          ),
          /*
          由于RotatedBox是作用于layout阶段，所以子组件会旋转90度（而不只是绘制的内容），
          decoration会作用到子组件所占用的实际空间上，所以最终就是上图的效果，读者可以和前面Transform.rotate示例对比理解。
           */
          SizedBox(
            height: 10,
          ),

          ///Container
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 120.0),
            //容器外填充
            constraints: BoxConstraints.tightFor(width: 80.0, height: 60.0),
            //卡片大小
            decoration: BoxDecoration(
                //背景装饰
                gradient: RadialGradient(//背景径向渐变
                    colors: [Colors.red, Colors.orange], center: Alignment.topLeft, radius: .98),
                boxShadow: [
                  //卡片阴影
                  BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0)
                ]),
            transform: Matrix4.rotationZ(.2),
            //卡片倾斜变换
            alignment: Alignment.center,
            //卡片内文字居中
            child: Text(
              //卡片文字
              "5.20", style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ///margin 容器外补白 ; padding 容器内补白
        ],
      ),
    );
  }
}

///Scaffold
class ScaffoldTestWidget extends StatefulWidget {
  @override
  _ScaffoldTestWidgetState createState() => _ScaffoldTestWidgetState();
}

class _ScaffoldTestWidgetState extends State<ScaffoldTestWidget>
    with SingleTickerProviderStateMixin {
  ///TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的
  TabController _tabController; //需要定义一个Controller
  List _tabs = ["新闻", "历史", "图片"];

  //底部导航索引位置
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      AppBar({
        Key key,
        this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
        this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
        this.title,// 页面标题
        this.actions, // 导航栏右侧菜单
        this.bottom, // 导航栏底部菜单，通常为Tab按钮组
        this.elevation = 4.0, // 导航栏阴影
        this.centerTitle, //标题是否居中
        this.backgroundColor,
        ...   //其它属性见源码注释
      })
       */
      appBar: AppBar(
        //导航栏
        title: const Text("标题"),
        elevation: 3.0,
        /*
        Tab({
          Key key,
          this.text, // 菜单文本
          this.icon, // 菜单图标
          this.child, // 自定义组件样式
        })
         */
        bottom: TabBar(
            //生成Tab菜单
            controller: _tabController,
            tabs: _tabs
                .map((e) => Tab(
                      //text: e,
                      //自定义样式
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.tag_faces,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(e),
                        ],
                      ),
                    ))
                .toList()),

        ///如果给Scaffold添加了抽屉菜单，默认情况下Scaffold会自动将AppBar的leading设置为菜单按钮（如上面截图所示），
        ///点击它便可打开抽屉菜单。如果我们想自定义菜单图标，可以手动来设置leading
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              // 代码中打开抽屉菜单的方法在ScaffoldState中，通过Scaffold.of(context)可以获取父级最近的Scaffold 组件的State对象。
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),

      ///抽屉
      drawer: new _MyDrawer(),

      ///bottomNavigationBar
      // bottomNavigationBar: BottomNavigationBar(
      //   // 底部导航
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
      //     BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
      //   ],
      //   currentIndex: _selectedIndex,
      //   fixedColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),

      ///Material组件库中提供了一个BottomAppBar 组件，它可以和FloatingActionButton配合实现这种“打洞”效果
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home)),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.business)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      //可以看到，上面代码中没有控制打洞位置的属性，实际上，打洞的位置取决于FloatingActionButton的位置:
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // BottomAppBar的shape属性决定洞的外形，CircularNotchedRectangle实现了一个圆形的外形，
      // 我们也可以自定义外形，比如，Flutter Gallery示例中就有一个“钻石”形状的示例，读者感兴趣可以自行查看。

      ///
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: const Icon(Icons.add),
          onPressed: _onAdd),

      ///Material库提供了一个TabBarView组件，通过它不仅可以轻松的实现Tab页，而且可以非常容易的配合TabBar来实现同步切换和滑动状态同步
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((e) {
          //创建3个Tab页
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}

class _MyDrawer extends StatelessWidget {
  const _MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "static/images/landscape.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "javakam",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
