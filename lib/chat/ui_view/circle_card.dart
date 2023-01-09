// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:manage_app/utils/manage_theme.dart';

class CircleCard extends StatefulWidget {
  const CircleCard({super.key});

  @override
  State<CircleCard> createState() => _CircleCardState();
}

class _CircleCardState extends State<CircleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ManageTheme.nearlyBlack,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 3.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                3.0, // Move to right 10  horizontally
                2.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(35)),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 15,
          width: 15,
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: ManageTheme.nearlyWhite,
              borderRadius: BorderRadius.circular(7.5)),
          child: Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: ManageTheme.successGreen,
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    );
  }
}
