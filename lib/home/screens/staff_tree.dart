import 'package:flutter/material.dart';
import 'package:manage_app/utils/manage_theme.dart';

class StaffTreeScreen extends StatefulWidget {
  const StaffTreeScreen({super.key});

  @override
  State<StaffTreeScreen> createState() => _StaffTreeScreenState();
}

class _StaffTreeScreenState extends State<StaffTreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Staff Tree",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
    );
  }
}
