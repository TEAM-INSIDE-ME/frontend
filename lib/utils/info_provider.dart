import 'package:flutter/material.dart';

class InfoProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String remindTime = '';
  String password = '';
  late int frequency;
  late int weeksOfConsecutiveSuccess;
  late int totalMinute;
  String gender = '';
  late DateTime birth;
  String job = '';
  String purpose = '';

  // String get _name => name;
  // String get _emial => email;
  // String get _remindTime => remindTime;
  // String get _password => password;
  // int get _frequency => frequency;
  // int get _weeksOfConsecutiveSuccess => weeksOfConsecutiveSuccess;
  // int get _totalMinute => totalMinute;
  // String get _gender => gender;
  // DateTime get _birth => birth;
  // String get _job => job;
  // String get _purpose => purpose;

  void getName(String newName) {
    name = newName;
    notifyListeners();
  }

  void getGender(String newGender) {
    gender = newGender;
    notifyListeners();
  }

  void getBirth(DateTime newDay) {
    birth = newDay;
    notifyListeners();
  }

  void getPassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }
}
