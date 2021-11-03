
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Global {
  static int count;
  static SharedPreferences prefs;
  //初始化全局信息
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    if(prefs==null) {
      count = 0;
    }
    else {
      count = prefs.getInt('count');
      if(count == null) {
        count = 0;
      }
    }

  }

  static Future<void> setCount(int count) async {
    prefs.setInt('count', count);
  }



}
