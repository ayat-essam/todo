import 'package:flutter/material.dart';
import '../model/user_model.dart';
class userProvider with ChangeNotifier{
  UserModel? currentUser;

  void updateUser(UserModel? user){
    currentUser = user;
    notifyListeners();
  }
}