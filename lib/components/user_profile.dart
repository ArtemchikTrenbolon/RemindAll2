
import 'package:flutter/material.dart';

class UserProfile extends ChangeNotifier {
  String _userName = "User";

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
