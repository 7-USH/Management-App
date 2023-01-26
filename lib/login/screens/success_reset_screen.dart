import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manage_app/utils/manage_theme.dart';

import '../login.dart';

class SuccessPassResetScreen extends StatefulWidget {
  const SuccessPassResetScreen({super.key});

  @override
  State<SuccessPassResetScreen> createState() => _SuccessPassResetScreenState();
}

class _SuccessPassResetScreenState extends State<SuccessPassResetScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ManageTheme.nearlyWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset(
                "assets/gifs/pass_reset_success.json",
                frameRate: FrameRate.max,
                repeat: false,
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 1.2,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 40),
              child: Text(
                "Password Reset Successfully!",
                style: ManageTheme.appText(
                    size: MediaQuery.of(context).size.width / 22,
                    weight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Login();
                  }));
                },
                style: ManageTheme.buttonStyle(
                    backColor: Colors.white,
                    fontSize: 15,
                    borderColor: ManageTheme.nearlyBlack),
                child: const Text(
                  "Head to Login Page",
                  style: TextStyle(color: ManageTheme.nearlyBlack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
