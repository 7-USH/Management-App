import 'package:flutter/material.dart';
import 'package:manage_app/signup/screens/verify_screen.dart';

import '../../utils/manage_theme.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final emailController = TextEditingController();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Forgot Password?",
              style: ManageTheme.appText(
                  size: 35, weight: FontWeight.w600, isShadow: true),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Don't worry! it occurs. Please enter the email address linked with your account",
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
                hint: "Enter your email",
                fontSize: 16,
                prefixIcon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return VerifyScreen(email: emailController.text);
                  }));
                },
                style: ManageTheme.buttonStyle(
                  backColor: ManageTheme.nearlyBlack,
                  fontSize: 15,
                ),
                child: Text(
                  "Send Verification Code",
                  style: ManageTheme.appText(
                      size: 15,
                      weight: FontWeight.w600,
                      color: ManageTheme.backgroundWhite),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Remember Password? ",
                  style: ManageTheme.appText(
                      size: 15,
                      weight: FontWeight.w500,
                      color: ManageTheme.nearlyBlack),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    " Login",
                    style: ManageTheme.appText(
                        size: 15,
                        weight: FontWeight.bold,
                        color: ManageTheme.nearlyBlack),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
