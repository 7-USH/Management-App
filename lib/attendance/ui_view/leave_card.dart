// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:manage_app/utils/manage_theme.dart';

class LeaveCard extends StatelessWidget {
  LeaveCard(
      {super.key,
      required this.text,
      required this.number,
      required this.color});
  String text;
  String number;
  Color color;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chip(
              backgroundColor: color,
              padding: const EdgeInsets.all(5),
              label: Text(
                number,
                style: ManageTheme.insideAppText(
                    size: screenWidth / 15,
                    weight: FontWeight.w600,
                    color: ManageTheme.backgroundWhite),
              )),
          SizedBox(
            height: screenWidth / 26,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: ManageTheme.insideAppText(
                size: screenWidth / 19, weight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
