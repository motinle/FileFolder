


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/global.dart';
import 'package:path_provider/path_provider.dart';

class FileOperationRoute extends StatefulWidget {

  @override
  _FileOperationRouteState createState() => _FileOperationRouteState();
}


class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _readCounter().then((value){
      setState(() {
        _counter = value;
      });
    });
  }


  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Global.myThemeData(context),
      child: Scaffold(
        appBar: AppBar(
            title: Text('文件操作'),

        ),
        body: Center(
          child: Column(
            children: [
              Text('点击了 $_counter 次'),
              SizedBox(
                height: 120,
              ),
              Text('点击了 $_counter 次'),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),




        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          child: Icon(Icons.add),
        ),
      ),

    );




  }
}