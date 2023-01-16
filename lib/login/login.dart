// ignore_for_file: unused_field, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/login/models/login_model.dart';
import 'package:manage_app/login/models/session_model.dart';
import 'package:manage_app/login/screens/forgot_screen.dart';
import 'package:manage_app/login/service/login_service.dart';
import 'package:manage_app/signup/signup.dart';
import 'package:manage_app/utils/manage_theme.dart';

import '../app/app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  LoginService service = LoginService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ManageTheme.nearlyWhite,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/manage.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "MANAGEMENT",
                    style: ManageTheme.appText(
                        size: 25, weight: FontWeight.w900, isShadow: true),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email";
                          } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value)) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                        decoration: ManageTheme.waInputDecoration(
                          hint: "Email",
                          fontSize: 16,
                          prefixIcon: Icons.email,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        decoration: ManageTheme.waInputDecoration(
                            hint: "Password",
                            prefixIcon: Icons.lock,
                            fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ForgotScreen();
                          }));
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 8, bottom: 5),
                          child: Text(
                            "Forgot Password?",
                            style: ManageTheme.appText(
                                size: 13,
                                weight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.34,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  service
                                      .loginUser(
                                          model: LoginModel(
                                              username: emailController.text,
                                              password:
                                                  passwordController.text),
                                          context: context)
                                      .then((value) {
                                    if (value is SessionModel) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return App();
                                      }));
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  });
                                }
                              },
                              style: ManageTheme.buttonStyle(
                                  backColor: ManageTheme.nearlyBlack,
                                  fontSize: 15),
                              child: _isLoading
                                  ? Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                      color: Colors.white,
                                      size: 20,
                                    ))
                                  : const Text(
                                      "Login",
                                    ),
                            ),
                          ),
                          Text(
                            "or",
                            style: ManageTheme.appText(
                                size: 16, weight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.fingerprint,
                            color: ManageTheme.nearlyBlack,
                            size: 50,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Don't have an account?",
                  style:
                      ManageTheme.appText(size: 16, weight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ManageTheme.buttonStyle(
                            backColor: Colors.white,
                            fontSize: 15,
                            borderColor: ManageTheme.nearlyBlack),
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: ManageTheme.nearlyBlack),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const SignUp();
                          }));
                        },
                        style: ManageTheme.buttonStyle(
                            backColor: Colors.white,
                            fontSize: 15,
                            borderColor: ManageTheme.nearlyBlack),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: ManageTheme.nearlyBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
