import "package:flutter/material.dart";
import "package:instagramclone/Resources/auth_methods.dart";
import "package:instagramclone/models/user.dart";

class UserProvider with ChangeNotifier {
  User? _user;
  User get getUser => _user!;
  final AuthMethods _authMethod = AuthMethods();

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
 