import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/utils/utils.dart';

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
