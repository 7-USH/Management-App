import 'package:flutter/material.dart';
import 'package:manage_app/utils/manage_theme.dart';

class GuestRelationScreen extends StatefulWidget {
  const GuestRelationScreen({super.key});

  @override
  State<GuestRelationScreen> createState() => _GuestRelationScreenState();
}

class _GuestRelationScreenState extends State<GuestRelationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Guest Relation",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
    );
  }
}
