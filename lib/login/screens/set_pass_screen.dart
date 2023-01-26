// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/login/models/reset_pass_model.dart';
import 'package:manage_app/login/models/session_model.dart';
import 'package:manage_app/login/screens/success_reset_screen.dart';
import 'package:manage_app/login/service/login_service.dart';
import 'package:manage_app/utils/manage_theme.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({super.key});

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  LoginService service = LoginService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ManageTheme.nearlyWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: ManageTheme.nearlyBlack,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create new password",
                  style: ManageTheme.appText(
                      size: MediaQuery.of(context).size.width / 14,
                      weight: FontWeight.w600,
                      isShadow: true),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Your new password must be unique from those previously used.",
                  style: ManageTheme.appText(
                      size: 15,
                      weight: FontWeight.w500,
                      color: ManageTheme.nearlyBlack),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autofocus: true,
                  controller: _newpassController,
                  cursorColor: ManageTheme.nearlyBlack,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new password";
                    } else if (value.length < 8) {
                      return "Password should be atleast 8 characters long";
                    }
                    return null;
                  },
                  decoration: ManageTheme.waInputDecoration(
                    hint: "New Password",
                    fontSize: 16,
                    prefixIcon: Icons.lock,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPassController,
                  autofocus: true,
                  cursorColor: ManageTheme.nearlyBlack,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    } else if (value.length < 8) {
                      return "Password should be atleast 8 characters long";
                    } else if (_newpassController.text !=
                        _confirmPassController.text) {
                      return "Your password and confirmation password do not match";
                    }
                    return null;
                  },
                  decoration: ManageTheme.waInputDecoration(
                    hint: "Confirm Password",
                    fontSize: 16,
                    prefixIcon: Icons.lock_person,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          service
                              .resetPassword(
                                  model: ResetPassModel(
                                      newPassword: _confirmPassController.text),
                                  context: context)
                              .then((value) {
                            if (value!=null) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const SuccessPassResetScreen();
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
                              "Reset Password",
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
