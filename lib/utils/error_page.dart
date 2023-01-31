// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manage_app/login/login.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key, required this.text, required this.statusCode});
  String text;
  int statusCode;

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
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (statusCode >= 500) {
                        pref.clear().then((value) {
                          if (value) {
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          }
                        });
                      } else {
                        await Navigator.of(context, rootNavigator: true)
                            .pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      }
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
