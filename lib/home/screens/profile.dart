// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:manage_app/home/ui_view/profile_card.dart';
import 'package:manage_app/login/login.dart';
import 'package:manage_app/utils/manage_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
              ProfileCard(data: Icons.person, text: "Tushar Mali"),
              ProfileCard(data: Icons.email, text: "tush1245@gmail.com"),
              ProfileCard(data: Icons.phone, text: "7262818443"),
              ProfileCard(data: Icons.account_balance, text: "281310381397")
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.34,
                  height: 40,
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
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.34,
                  height: 40,
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
                        backColor: ManageTheme.nearlyBlack, fontSize: 15),
                    child: const Text(
                      "LogOut",
                    ),
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
