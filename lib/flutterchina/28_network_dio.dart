import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///dio
///https://github.com/flutterchina/dio
///https://book.flutterchina.club/chapter11/dio.html
/*
示例: 通过Github开放的API来请求 flutterchina 组织下的所有公开的开源项目，实现：
1.在请求阶段弹出loading
2.请求结束后，如果请求失败，则展示错误信息；如果成功，则将项目名称列表展示出来。
 */
class DioTestRoute extends StatefulWidget {
  DioTestRoute({Key key}) : super(key: key);

  @override
  _FutureBuilderRouteState createState() {
    return _FutureBuilderRouteState();
  }
}

class _FutureBuilderRouteState extends State<DioTestRoute> {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('网络操作 Dio')),
      body: new Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //请求完成
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                //发生错误
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                //请求成功，通过项目信息构建用于显示项目名称的ListView
                return ListView(
                  children: response.data
                      .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                      .toList(),
                );
              }
              //请求未完成时弹出loading
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

///实例：Http分块下载
///https://book.flutterchina.club/chapter11/download_with_chunks.html
/*
原理: Http协议定义了分块传输的响应header字段，但具体是否支持取决于Server的实现，我们可以指定请求头的"range"字段来验证服务器是否支持分块传输。

基于此，我们可以设计一个简单的多线程的文件分块下载器，实现的思路是：

1.先检测是否支持分块传输，如果不支持，则直接下载；若支持，则将剩余内容分块下载。
2.各个分块下载时保存到各自临时文件，等到所有分块下载完后合并临时文件。
3.删除临时文件。
*/

/// Downloading by spiting as file in chunks
Future downloadWithChunks(
  url,
  savePath, {
  ProgressCallback onReceiveProgress,
}) async {
  const firstChunkSize = 102;
  const maxChunk = 3;

  int total = 0;
  var dio = Dio();
  var progress = <int>[];

  createCallback(no) {
    return (int received, _) {
      progress[no] = received;
      if (onReceiveProgress != null && total != 0) {
        onReceiveProgress(progress.reduce((a, b) => a + b), total);
      }
    };
  }

  Future<Response> downloadChunk(url, start, end, no) async {
    progress.add(0);
    --end;
    return dio.download(
      url,
      savePath + "temp$no",
      onReceiveProgress: createCallback(no),
      options: Options(
        headers: {"range": "bytes=$start-$end"},
      ),
    );
  }

  Future mergeTempFiles(chunk) async {
    File f = File(savePath + "temp0");
    IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead());
      await _f.delete();
    }
    await ioSink.close();
    await f.rename(savePath);
  }

  Response response = await downloadChunk(url, 0, firstChunkSize, 0);
  if (response.statusCode == 206) {
    total = int.parse(response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
    int reserved = total - int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
    int chunk = (reserved / firstChunkSize).ceil() + 1;
    if (chunk > 1) {
      int chunkSize = firstChunkSize;
      if (chunk > maxChunk + 1) {
        chunk = maxChunk + 1;
        chunkSize = (reserved / maxChunk).ceil();
      }
      var futures = <Future>[];
      for (int i = 0; i < maxChunk; ++i) {
        int start = firstChunkSize + i * chunkSize;
        futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
      }
      await Future.wait(futures);
    }
    await mergeTempFiles(chunk);
  }
}

main() async {
  var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
  var savePath = "./example/HBuilder.9.0.2.macosx_64.dmg";
  await downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
    if (total != -1) {
      print("${(received / total * 100).floor()}%");
    }
  });
}
