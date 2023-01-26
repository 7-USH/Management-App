// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:manage_app/chat/models/ModelProvider.dart';
import 'package:manage_app/utils/manage_theme.dart';

class CircleCard extends StatefulWidget {
  CircleCard({super.key, required this.model});
  User model;

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
          color: ManageTheme.nearlyWhite,
          border: Border.all(
              color: widget.model.is_online!
                  ? ManageTheme.successGreen
                  : Colors.grey,
              width: 2.5,
              strokeAlign: BorderSide.strokeAlignOutside),
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
      child: Center(
        child: Container(
          height: 66,
          width: 66,
          decoration: BoxDecoration(
              color: ManageTheme.nearlyBlack,
              borderRadius: BorderRadius.circular(33)),
        ),
      ),
    );
  }
}
