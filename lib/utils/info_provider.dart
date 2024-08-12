import 'package:flutter/material.dart';

class InfoProvider extends ChangeNotifier {
  String _name = '';
  late DateTime _birth;
  String _password = '';

  String get name => _name;
  DateTime get birth => _birth;
  String get password => _password;

  void getName(String newText) {
    _name = newText;
    notifyListeners();
  }

  void getBirth(DateTime newDay) {
    _birth = newDay;
    notifyListeners();
  }

  void getPassword(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }
}
