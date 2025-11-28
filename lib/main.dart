import 'package:flutter/material.dart';
//import 'package:flutter_application_login/login.dart';
import 'package:flutter_application_login/providers/auth_provider.dart';
import 'package:flutter_application_login/screens/home_screen.dart';
import 'package:flutter_application_login/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_)=>AuthProvider()..tryAutoLogin(),
  child: MainApp(),));
  // WidgetsFlutterBinding.ensureInitialized();

  // final authProvider=AuthProvider();
  // await authProvider.loadToken();
  // runApp(
  //   MultiProvider(providers: [ChangeNotifierProvider(create: (_)=> authProvider),],child: MainApp(),));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      home: auth.isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
