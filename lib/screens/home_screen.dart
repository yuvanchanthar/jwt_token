import 'package:flutter/material.dart';
import 'package:flutter_application_login/providers/auth_provider.dart';
import 'package:flutter_application_login/screens/login_screen.dart';
import 'package:flutter_application_login/services/api_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var profile;
  @override void initState() {
  
    super.initState();
    loadProfile();
  }
  void loadProfile()async{
    profile=await ApiService().getUserProfile();
  }
  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthProvider>(context);
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(onPressed: ()async{
            await auth.logout();Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: profile==null ? CircularProgressIndicator(): Text("User Profile: $profile"),
      ),
    );
  }
}