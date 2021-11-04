import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/ProfileChangeNotifier.dart';
import 'package:my_flutter/UrlLauncherRoute.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'FileOperationRoute.dart';
import 'global.dart';

//void main() => runApp(MyApp());
// void main() => Global.init().then((e) => runApp(MyApp()));

void main() {
  Global.init().then((value) {
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<UserModel>.value(value: UserModel()),
        ChangeNotifierProvider<UserModel2>.value(value: UserModel2()),
      ],
          child:_widgetForRoute(ui.window.defaultRouteName),
          // child: MyApp()
      ),
    );
  });
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'myApp':
      return new MyApp();
    case 'url':
      return new UrlLauncherRoute2();

    default:
      return new UrlLauncherRoute2();
      // return Center(
      //   child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      // );
  }
}



class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page2'),
      // routes: <String, WidgetBuilder>{
      //   "login": (context) => LoginRoute(),
      //   "themes": (context) => ThemeChangeRoute(),
      //   "language": (context) => LanguageRoute(),
      // },
      // routes:<String, WidgetBuilder> {
      //   'myApp':(context)=> MyApp(),
      //   'fileOperation':(context)=>FileOperationRoute(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  int _counter = Global.count;

  void _incrementCounter() async {

    String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
    setState(() {
      _counter++;
      Global.setCount(_counter);


      final user = Provider.of<UserModel>(context,listen: false);
      final user2 = Provider.of<UserModel2>(context,listen: false);
      user2.increment();
      user.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    _nextButtonAction() {
      // Navigator.of(context).pushNamed('fileOperation');
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => FileOperationRoute()));
    }
    _getParamFromIOS() async {
      dynamic result;
      try {
        const methodChannel = const MethodChannel('com.pages.your/native_get');
        result = await methodChannel.invokeMethod('getParamFromIOS');
        print(result);
      } on PlatformException {
        result = "error";
      }
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Global.myThemeData(context),
      home: Scaffold(
          appBar:  AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () async {
              print("invokeMethod");
              const methodChannel = const MethodChannel('com.pages.your/native_get');
              Map<String, dynamic> map = {"code": "200", "data":[1,2,3]};
              await methodChannel.invokeMethod('back', map);
              print("invokeMethod2");
            },),
          ),
          body: Center(
            // Center is a la            // in the middle of the parent.yout widget. It takes a single child and positions it
            child: (Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Builder(builder: (context){
                  final user = Provider.of<UserModel>(context,listen:false);
                  return Text("总价: ${user.value}");
                }),
                Builder(builder: (context){
                  final user2 = Provider.of<UserModel2>(context,listen:false);
                  return Text("总价2: ${user2.value}");
                }),
                Builder(builder: (context){
                  return Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                }),
                Builder(builder: (context){
                  return IconButton(
                      onPressed: _nextButtonAction,
                      icon: Icon(Icons.add_alarm),
                  );
                }),
                TextButton(onPressed: _getParamFromIOS, child: Text("getParamFromIOS")),

              ],
            )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          )
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


