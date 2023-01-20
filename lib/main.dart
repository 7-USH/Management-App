// ignore_for_file: prefer_const_constructors, unused_import, unused_element, avoid_print
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_app/amplifyconfiguration.dart';
import 'package:manage_app/app/app.dart';
import 'package:manage_app/chat/view_models/chatroom_list_viewmodel.dart';
import 'package:manage_app/chat/view_models/users_list_viewmodel.dart';
import 'package:manage_app/home/home.dart';
import 'package:manage_app/login/login.dart';
import 'package:manage_app/login/screens/set_pass_screen.dart';
import 'package:manage_app/login/screens/success_reset_screen.dart';
import 'package:manage_app/signup/screens/subplan_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat/models/ModelProvider.dart';

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
    if (!Amplify.isConfigured) {
      _configureAmplify();
      setState(() {});
      return;
    }
    super.initState();
  }

  void _configureAmplify() async {
    AmplifyDataStore datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    await Amplify.addPlugins([datastorePlugin, AmplifyAPI()]);

    try {
      await Amplify.configure(amplifyconfig);
      switchHome();
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  void switchHome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? session = sharedPreferences.getString("session");
    if (session == null ) {
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
