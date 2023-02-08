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
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
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
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              surfaceTintColor: Colors.transparent),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return ForgotScreen();
                            }));
                          },
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
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
                                          password: passwordController.text),
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
                          ),
                          child: _isLoading
                              ? Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 20,
                                ))
                              : Text(
                                  "LOGIN",
                                  style: ManageTheme.insideAppText(
                                      size: MediaQuery.of(context).size.width /
                                          22,
                                      weight: FontWeight.bold,
                                      color: ManageTheme.backgroundWhite),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: ManageTheme.appText(
                          size: 16,
                          weight: FontWeight.normal,
                          color: Colors.black54),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            surfaceTintColor: Colors.transparent),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const SignUp();
                          }));
                        },
                        child: Text(
                          "Sign Up",
                          style: ManageTheme.appText(
                              size: 16,
                              weight: FontWeight.bold,
                              color: ManageTheme.nearlyBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
