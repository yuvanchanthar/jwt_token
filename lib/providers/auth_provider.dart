import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_login/models/user_model.dart';
import 'package:flutter_application_login/services/api_service.dart';
//import 'package:flutter_application_login/utils/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier{
  final _storage = const FlutterSecureStorage();
  //String? token;
  UserModel? _user;

  UserModel? get user=> _user;
  bool get isLoggedIn => _user != null;

  Future<bool> login(String email,String password)async{
    try{
      String token= await ApiService().login(email, password);
      _user= UserModel(email: email, token: token);
      await _storage.write(key: "user", value: jsonEncode(_user!.toJson()));
      notifyListeners();
      return true;
    }catch (e){
      return false;
    }
    // token=await ApiService().login(email, password);
    // if(token != null){
    //   await SecureStorage().saveToken(token!);
    //   notifyListeners();
    //   return true;

    
  }
  Future<void> tryAutoLogin()async{
    String? userJson=await _storage.read(key: "user");
    if(userJson != null){
      _user=UserModel.fromJson(jsonDecode(userJson));
      notifyListeners();
    }
  }
  Future logout()async{
    _user=null;
    await _storage.delete(key: "user");
    notifyListeners();
  }
}