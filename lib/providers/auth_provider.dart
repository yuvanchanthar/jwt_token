import 'package:flutter/material.dart';
import 'package:flutter_application_login/services/api_service.dart';
import 'package:flutter_application_login/utils/secure_storage.dart';

class AuthProvider extends ChangeNotifier{
  String? token;

  bool get isLoggedIn => token != null;

  Future<bool> loginUser(String email,String password)async{
    token=await ApiService().login(email, password);
    if(token != null){
      await SecureStorage().saveToken(token!);
      notifyListeners();
      return true;

    }return false;
  }
  Future loadToken()async{
    token= await SecureStorage().getToken();
    notifyListeners();
  }
  Future logout()async{
    token=null;
    await SecureStorage().logout();
    notifyListeners();
  }
}