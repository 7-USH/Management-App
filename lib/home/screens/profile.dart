// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:manage_app/home/models/profile_detail_model.dart';
import 'package:manage_app/home/ui_view/profile_card.dart';
import 'package:manage_app/login/login.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.model});
  ProfileDetailModel model;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Profile",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: ManageTheme.nearlyBlack,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              ProfileCard(
                  data: Icons.person, text: widget.model.fullName ?? "User"),
              ProfileCard(
                  data: Icons.email,
                  text: widget.model.email ?? "random@gmail.com"),
              ProfileCard(
                  data: Icons.phone,
                  text: widget.model.mobileNo ?? "1234567890"),
              ProfileCard(
                  data: Icons.account_balance,
                  text: widget.model.bankAccountNo ?? "281310381397")
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ManageTheme.buttonStyle(
                        backColor: ManageTheme.backgroundWhite,
                        fontSize: 15,
                        borderColor: ManageTheme.nearlyBlack,
                        fontColor: ManageTheme.nearlyBlack),
                    child: Text(
                      "Edit Profile",
                      style: ManageTheme.appText(
                          size: 15, weight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.remove("session").then((value) {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: Login(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.scale);
                      });
                    },
                    style: ManageTheme.buttonStyle(
                      backColor: Colors.redAccent.shade100,
                      fontSize: 15,
                      borderColor: ManageTheme.nearlyBlack,
                    ),
                    child: Text("LogOut",
                        style: ManageTheme.appText(
                          size: 15,
                          weight: FontWeight.w600,
                          color: ManageTheme.nearlyBlack,
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
