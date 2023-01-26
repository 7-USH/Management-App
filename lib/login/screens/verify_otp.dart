// ignore_for_file: prefer_final_fields, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manage_app/login/models/reset_pass_model.dart';
import 'package:manage_app/login/models/session_model.dart';
import 'package:manage_app/login/screens/set_pass_screen.dart';
import 'package:manage_app/login/service/login_service.dart';
import 'package:manage_app/utils/manage_theme.dart';

class VerifyOTPScreen extends StatefulWidget {
  VerifyOTPScreen({super.key, required this.email});
  String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "OTP Verification",
                style: ManageTheme.appText(
                    size: MediaQuery.of(context).size.width / 14,
                    weight: FontWeight.w600,
                    isShadow: true),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Enter the verification code we just sent on your email address.",
                style: ManageTheme.appText(
                    size: 15,
                    weight: FontWeight.w500,
                    color: ManageTheme.nearlyBlack),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _textFieldOTP(
                      first: true, last: false, controller: _controller1),
                  _textFieldOTP(
                      first: false, last: false, controller: _controller2),
                  _textFieldOTP(
                      first: false, last: false, controller: _controller3),
                  _textFieldOTP(
                      first: false, last: true, controller: _controller4),
                ],
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
                      FocusScope.of(context).unfocus();

                      String activationCode = _controller1.text +
                          _controller2.text +
                          _controller3.text +
                          _controller4.text;

                      if (activationCode.length == 4) {
                        setState(() {
                          _isLoading = true;
                        });
                        service
                            .validateOTP(
                                model: ResetPassModel(
                                  email: widget.email,
                                  resetCode: int.parse(activationCode),
                                ),
                                context: context)
                            .then((value) {
                          setState(() {
                            _isLoading = false;
                          });
                          _controller1.clear();
                          _controller2.clear();
                          _controller3.clear();
                          _controller4.clear();
                          if (value is SessionModel) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const SetPassScreen();
                            }));
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
                            "Verify",
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

  Widget _textFieldOTP(
      {required bool first, last, required TextEditingController controller}) {
    return SizedBox(
      height: 80,
      child: Center(
        child: AspectRatio(
          aspectRatio: 0.8,
          child: TextField(
            controller: controller,
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: ManageTheme.appText(size: 20, weight: FontWeight.w600),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: ManageTheme.nearlyBlack),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
