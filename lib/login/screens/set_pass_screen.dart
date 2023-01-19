// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/utils/manage_theme.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({super.key});

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create new password",
                style: ManageTheme.appText(
                    size: MediaQuery.of(context).size.width/14, weight: FontWeight.w600, isShadow: true),
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
                cursorColor: ManageTheme.nearlyBlack,
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
                  hint: "New Password",
                  fontSize: 16,
                  prefixIcon: Icons.lock,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: true,
                cursorColor: ManageTheme.nearlyBlack,
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
                    onPressed: () {},
                    style: ManageTheme.buttonStyle(
                      backColor: ManageTheme.nearlyBlack,
                      fontSize: 15,
                    ),
                    child: const Text(
                      "Reset Password",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
