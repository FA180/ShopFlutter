import 'package:dono/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    crNumber: '',
    email: '',
    password: '',
    token: '',
    phoneNumber: '',
    status: false,
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;

    notifyListeners();
  }
}
