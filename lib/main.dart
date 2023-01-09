// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_app/app/app.dart';
import 'package:manage_app/home/home.dart';
import 'package:manage_app/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const orientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ];
  SystemChrome.setPreferredOrientations(orientations);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = const Scaffold();

  @override
  void initState() {
    switchHome();
    super.initState();
  }

  void switchHome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? session = sharedPreferences.getString("session");
    if (session == null) {
      setState(() {
        home = const Login();
      });
    } else {
      setState(() {
        home = App();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Management App', debugShowCheckedModeBanner: false, home: home);
  }
}
