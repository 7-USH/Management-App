// ignore_for_file: unused_field, prefer_final_fields, unused_local_variable

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/signup/models/register_model.dart';
import 'package:manage_app/signup/screens/verify_screen.dart';
import 'package:manage_app/signup/service/signup_service.dart';
import 'package:manage_app/utils/manage_theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userIdController = TextEditingController(text: "tush1290");
  final passwordController = TextEditingController(text: "11tusmli89");
  final emailIdController =
      TextEditingController(text: "trmali_b20@it.vjti.ac.in");
  final mobileController = TextEditingController(text: "7262818443");
  final addressController = TextEditingController(text: "Badlapur Maharashtra");
  final _formKey = GlobalKey<FormState>();
  SignUpService service = SignUpService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Hello!\nSignup to\nget started.",
                style: ManageTheme.appText(
                    size: 35, weight: FontWeight.bold, isShadow: true),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: userIdController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter user name";
                        }
                        return null;
                      },
                      decoration: ManageTheme.waInputDecoration(
                        hint: "User Id",
                        fontSize: 16,
                        prefixIcon: Icons.person,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        } else if (value.length < 8) {
                          return "Password should be atleast 9 characters long";
                        }
                        return null;
                      },
                      decoration: ManageTheme.waInputDecoration(
                          hint: "Password",
                          prefixIcon: Icons.lock,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailIdController,
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
                        hint: "Email address",
                        fontSize: 16,
                        prefixIcon: Icons.mail,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: mobileController,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter phone number";
                        } else if (value.length != 10) {
                          return "Phone number should be of 10 digits";
                        }
                        return null;
                      },
                      decoration: ManageTheme.waInputDecoration(
                          hint: "Phone number",
                          prefixIcon: Icons.phone,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter address";
                        } else if (value.length < 10) {
                          return "Address should contain atleast 10 characters";
                        }
                        return null;
                      },
                      decoration: ManageTheme.waInputDecoration(
                        hint: "Address",
                        fontSize: 16,
                        prefixIcon: Icons.home,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        service
                            .registerUser(
                                model: RegisterModel(
                                    email: emailIdController.text,
                                    fullName: userIdController.text,
                                    password: passwordController.text,
                                    mobileNo: mobileController.text,
                                    address: addressController.text),
                                context: context)
                            .then((value) {
                          if (value is RegisterModel) {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return VerifyScreen(
                                email: emailIdController.text,
                              );
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
                      fontSize: 15,
                    ),
                    child: _isLoading
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 30,
                          ))
                        : const Text(
                            "Create an Account",
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
