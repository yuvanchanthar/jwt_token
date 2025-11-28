import 'package:flutter/material.dart';
import 'package:flutter_application_login/providers/auth_provider.dart';
import 'package:flutter_application_login/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final emailCtrl=TextEditingController();
    final passwordCtrl= TextEditingController();
    bool loading =false;
  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthProvider>(context);

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
          loading ? const CircularProgressIndicator(): 
          ElevatedButton(onPressed: ()async{
            setState(() {
              loading=true;
            });
            bool success= await auth.login(emailCtrl.text.trim(), passwordCtrl.text.trim());
            setState(() {
              loading=false;

            });
            if(success){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed, try again')));
            }
          }, child: Text("Login")),
          // ElevatedButton(onPressed:()async{
          //   final success= await auth.loginUser(emailCtrl.text, passwordCtrl.text);
          //   if(success){
          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
          //   }
          //   else{
          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed")));
          //   }
          // } , child: Text('login')),
        ],
      ),),
    );
  }
}