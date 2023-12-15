import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abordo App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (_)=> const LoginScreen(),
        'activar': (_)=> const ActivarScreen(),
        'contrasena': (_)=> const ContrasenaScreen(),
        'home': (_)=> const HomeScreen(),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor:  Colors.grey[300]),
    );
  }
}