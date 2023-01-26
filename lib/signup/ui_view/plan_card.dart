// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart' as Bd;
import 'package:flutter/material.dart';
import 'package:manage_app/signup/models/plan_model.dart';
import 'package:manage_app/utils/manage_theme.dart';

class PlanCard extends StatefulWidget {
  PlanCard({super.key, required this.model, required this.isHighlighted});
  PlanModel model;
  bool isHighlighted;
  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  @override
  Widget build(BuildContext context) {
    return Bd.Badge(
      badgeColor: ManageTheme.successGreen,
      showBadge: widget.isHighlighted,
      toAnimate: widget.isHighlighted,
      animationType: Bd.BadgeAnimationType.scale,
      badgeContent: const Icon(
        Icons.check,
        color: ManageTheme.nearlyWhite,
      ),
      stackFit: StackFit.expand,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(3, 3),
                  spreadRadius: 1,
                  blurRadius: 1)
            ],
            border: Border.all(
                width: widget.isHighlighted ? 1.5 : 1,
                color: widget.isHighlighted
                    ? ManageTheme.nearlyBlack
                    : Colors.grey.withOpacity(0.25)),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "${widget.model.minMembers!.toInt()}-${widget.model.maxMembers!.toInt()}",
                  style: ManageTheme.appText(
                      size: 22,
                      weight: FontWeight.w600,
                      color: ManageTheme.nearlyBlack),
                ),
                Text(
                  "Members",
                  style: ManageTheme.appText(size: 15, weight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Rs.${widget.model.price!.toInt()}",
              style: ManageTheme.appText(
                  size: 20,
                  weight: FontWeight.w600,
                  color: widget.isHighlighted
                      ? ManageTheme.nearlyBlack
                      : Colors.grey.withOpacity(0.7)),
            )
          ],
        ),
      ),
    );
  }
}
