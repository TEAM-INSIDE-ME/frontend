import 'package:flutter/material.dart';

class InfoProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String remindTime = '';
  String password = '';
  int frequency = 0;
  late int totalMinute;
  String gender = '';
  String birth = '';
  String job = '';
  String purpose = '';
  late String resolution = '';

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
  String get _resulution => resolution;

  void saveName(String newName) {
    name = newName;
    notifyListeners();
  }

  void saveGender(String newGender) {
    gender = newGender;
    notifyListeners();
  }

  void saveBirth(DateTime newDay) {
    birth = newDay.toIso8601String();
    notifyListeners();
  }

  void saveRemindTime(String newRemindTime) {
    remindTime = newRemindTime;
    notifyListeners();
  }

  void savePurpose(String newPurpose) {
    purpose = newPurpose;
    notifyListeners();
  }

  void saveJob(String newJob) {
    job = newJob;
    notifyListeners();
  }

  void savePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void saveResolution(String newResolution) {
    resolution = newResolution;
    notifyListeners();
  }

  void saveFrequency(int newFrequency) {
    frequency = newFrequency;
    notifyListeners();
  }
}
