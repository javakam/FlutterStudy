import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastNoContext extends StatelessWidget {
  void showLongToast() {
    Fluttertoast.showToast(
        msg: "This is Long Toast",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showWebColoredToast() {
    Fluttertoast.showToast(
        msg: "This is Colored Toast with android duration of 5 Sec",
        toastLength: Toast.LENGTH_SHORT,
        webBgColor: "#e74c3c",
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showColoredToast() {
    Fluttertoast.showToast(
        msg: "This is Colored Toast with android duration of 5 Sec",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showShortToast() {
    Fluttertoast.showToast(
        msg: "This is Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showTopShortToast() {
    Fluttertoast.showToast(
        msg: "This is Top Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void cancelToast() {
    Fluttertoast.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Toast'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(child: new Text('Show Long Toast'), onPressed: showLongToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(child: new Text('Show Short Toast'), onPressed: showShortToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(child: new Text('Show Center Short Toast'), onPressed: showCenterShortToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(child: new Text('Show Top Short Toast'), onPressed: showTopShortToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(child: new Text('Show Colored Toast'), onPressed: showColoredToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(child: new Text('Show  Web Colored Toast'), onPressed: showWebColoredToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                  child: new Text('Cancel Toasts'),
                  onPressed: cancelToast,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
