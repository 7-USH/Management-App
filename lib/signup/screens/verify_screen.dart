// ignore_for_file: prefer_const_constructors, unused_element, unused_field, prefer_final_fields, prefer_const_constructors_in_immutables, unused_local_variable, must_be_immutable
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:manage_app/login/models/session_model.dart';
import 'package:manage_app/signup/models/activate_model.dart';
import 'package:manage_app/signup/screens/subplan_screen.dart';
import 'package:manage_app/signup/service/signup_service.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({super.key, required this.email});
  String email;
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  SignUpService service = SignUpService();
  bool _isLoading = false;

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
          title: Text(
            "Verify Email",
            style: ManageTheme.appText(
                size: 25, weight: FontWeight.bold, isShadow: false),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "assets/gifs/email.json",
                height: 200,
                width: 200,
              ),
              Center(
                child: Text(
                  "A verification code has been sent to your email.\nThis code is valid for 15 minutes only.",
                  textAlign: TextAlign.center,
                  style: ManageTheme.appText(size: 16, weight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 45,
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
                            .activateCode(
                                model: ActivateModel(
                                    email: widget.email,
                                    activationCode: int.parse(activationCode)),
                                context: context)
                            .then((value) async {
                          if (value is SessionModel) {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref
                                .setString('session', value.session!)
                                .then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              _controller1.clear();
                              _controller2.clear();
                              _controller3.clear();
                              _controller4.clear();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return SubscriptionPlanScreen();
                              }));
                            });
                          } else {
                            _controller1.clear();
                            _controller2.clear();
                            _controller3.clear();
                            _controller4.clear();
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
