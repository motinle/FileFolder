import 'package:flutter/material.dart';

class SecondChangeNotifier extends ChangeNotifier {
  @override
  void notifyListeners() {
    print('d2');
    super.notifyListeners();
  }
}

class UserModel extends SecondChangeNotifier {
  int _count = 0;
  int get value => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

}
class User {
   int i;
}

class UserModel2 extends SecondChangeNotifier {
  static User _user;
  int get value  {
    if(_user != null) {
      return _user.i;
    }
    else
      {
        _user = User();
        _user.i = 555;
        return _user.i;
      }
  }

  void increment() {
    _user.i += 1;
    notifyListeners();
  }

}