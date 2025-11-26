import 'package:flutter/material.dart';
import 'package:flutter_application_login/providers/auth_provider.dart';
import 'package:flutter_application_login/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthProvider>(context);
    final emailCtrl=TextEditingController();
    final passwordCtrl= TextEditingController();
    return  Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        
      ),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(controller: emailCtrl,decoration: InputDecoration(labelText: "email")),
          TextField(controller: passwordCtrl,obscureText: true,decoration: InputDecoration(labelText: "Password"),),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed:()async{
            final success= await auth.loginUser(emailCtrl.text, passwordCtrl.text);
            if(success){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed")));
            }
          } , child: Text('login')),
        ],
      ),),
    );
  }
}