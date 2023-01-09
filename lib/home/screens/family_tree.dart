import 'package:flutter/material.dart';
import 'package:manage_app/utils/manage_theme.dart';

class FamilyTreeScreen extends StatefulWidget {
  const FamilyTreeScreen({super.key});

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManageTheme.nearlyWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ManageTheme.nearlyBlack,
        elevation: 0.0,
        title: Text(
          "Family Tree",
          style: ManageTheme.insideAppText(size: 25, weight: FontWeight.bold),
        ),
      ),
    );
  }
}
