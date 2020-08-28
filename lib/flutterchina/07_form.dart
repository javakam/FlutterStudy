import 'package:flutter/material.dart';
import 'package:flutter_app/flutterchina/utils.dart';

///表单Form
///
/// 提交之前校验：
/// 用户名不能为空，如果为空则提示“用户名不能为空”。
/// 密码不能小于6位，如果小于6为则提示“密码不能少于6位”。

/*
注意，登录按钮的onPressed方法中不能通过Form.of(context)来获取，原因是，此处的context为FormTestRoute的context，
而Form.of(context)是根据所指定context向根去查找，而FormState是在FormTestRoute的子树中，所以不行。
正确的做法是通过Builder来构建登录按钮，Builder会将widget节点的context作为回调参数

其实context正是操作Widget所对应的Element的一个接口，由于Widget树对应的Element都是不同的，所以context也都是不同的
 */
class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "用户名", hintText: "用户名或邮箱", icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: _pwdController,
                  decoration:
                      InputDecoration(labelText: "密码", hintText: "您的登录密码", icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),

              // 1.登录按钮
              Builder(
                builder: (context) {
                  return RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("登录"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      ///context 是 Form
                      //I/flutter ( 4181): onPressed: FormState#83cea
                      print("onPressed: " + Form.of(context).toString());

                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      if ((_formKey.currentState as FormState).validate()) {
                        //验证通过提交数据
                        toast("登录成功");
                      }
                    },
                  );
                },
              ),
              // 2.登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          ///context 是 Form State 的
                          //在这里不能通过此方式获取FormState，context不对
                          //I/flutter ( 4181): onPressed: null
                          print("onPressed: " + Form.of(context).toString());

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                            toast("登录成功");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
