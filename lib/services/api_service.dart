import 'dart:convert';

//import 'package:flutter_application_login/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
class ApiService {
  final String baseurl='https://reqres.in/api/login';

  Future<String> login(String email, String password) async{
    final url=Uri.parse("$baseurl/login");
    final response= await http.post(url,
    headers: {"Content_Type": "application/json"},
    body: jsonEncode({"email":email,"password":password}),
    );

    if(response.statusCode==200){
      final json=jsonDecode(response.body);
      return json["token"];
    }
    else{
      throw Exception("Invalid Email or Password");
    }
  }
  // Future<dynamic> getUserProfile()async{
  //   final token= await _storage.getToken();
  //   final response= await http.get(Uri.parse("$baseurl/profile"),
  //   headers: {"Authorization":"Bearer $token"}
  //   );
  //   if(response.statusCode==200){
  //     return jsonDecode(response.body);
  //   }else if(response.statusCode==401){
  //     return{"error": "Token expired"};
  //   }
  //   return{"error":"Something went wrong"};
  // }
}