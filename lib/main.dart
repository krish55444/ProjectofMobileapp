import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'create_account_screen.dart';
import 'loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/create-account': (context) => CreateAccountScreen(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
