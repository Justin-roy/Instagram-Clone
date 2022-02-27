import 'package:flutter/material.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/resources/auth_method.dart';

class UserProvider extends ChangeNotifier {
  CustomUser? _user;
  final AuthMethods _authMethods = AuthMethods();

  // Getter Funtion To Gets All Details
  CustomUser get getUser => _user!;

  Future<void> refreshUser() async {
    CustomUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
