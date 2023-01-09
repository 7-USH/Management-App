// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manage_app/login/login.dart';
import 'package:manage_app/utils/manage_theme.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ManageTheme.nearlyWhite,
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    LottieBuilder.asset(
                      "assets/gifs/error.json",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: ManageTheme.appText(
                            size: 20, weight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
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
              ]),
        ),
      ),
    );
  }
}


