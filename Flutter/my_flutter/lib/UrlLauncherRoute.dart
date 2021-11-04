

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/global.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UrlLauncherRoute',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UrlLauncherRoute(),
    );
  }
}



class UrlLauncherRoute extends StatefulWidget {

  @override
  _UrlLauncherRouteRouteState createState() => _UrlLauncherRouteRouteState();
}


class _UrlLauncherRouteRouteState extends State<UrlLauncherRoute> {
  int _counter = 0;


  Future<void> thirdapp() async {
    String url = 'kugou://';
    //判断是否可以拨打电话
    if(await canLaunch(url) != null){
      await launch(url);
    }else{
      throw '手机号异常，不能拨打电话';
    }
  }

  Future<void> sms() async {
    String url = 'sms:18922365974&body=123';
    //判断是否可以拨打电话
      if(await canLaunch(url) != null){
      await launch(url);
    }else{
      throw '手机号异常，不能拨打电话';
    }
  }

  Future<void> phone() async {
    String url = 'tel:18922365974';
    //判断是否可以拨打电话
    if(await canLaunch(url) != null){
    await launch(url);
    }else{
    throw '手机号异常，不能拨打电话';
    }
  }

  Future<void> email() async {
    String email = "mailto:motinle@163.com?subject=title&body=body";
    if (await canLaunch(email) != null) {
    await launch(email);
    } else {
    throw 'Could not send $email';
    }
  }

  Future<void> web() async {
    String url = "https://www.baidu.com";
    if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
    throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Global.myThemeData(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('UrlLauncherRoute'),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () async {
            print("invokeMethod");
            const methodChannel = const MethodChannel('com.pages.your/native_get');
            Map<String, dynamic> map = {"code": "200", "data":[1,2,3]};
            await methodChannel.invokeMethod('back', map);
            print("invokeMethod2");

          },),

        ),
        body: Center(
          child: Column(
            children: [
              TextButton(onPressed: sms,
              child: Text("短信"),),
              SizedBox(
                height: 40,
              ),
              TextButton(onPressed: phone,
                child: Text("电话：18922365974"),),
              SizedBox(
                height: 40,
              ),
              TextButton(onPressed: web,
                child: Text("百度"),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(onPressed: email,
                child: Text("email"),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(onPressed: thirdapp,
                child: Text("kugou"),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),


      ),

    );
  }
}