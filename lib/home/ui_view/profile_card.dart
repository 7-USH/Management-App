// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:manage_app/utils/manage_theme.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key, required this.data, required this.text});
  String text;
  IconData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.15)))),
      child: Row(
        children: [
          Icon(data),
          const SizedBox(
            width: 30,
          ),
          Text(
            text,
            style: ManageTheme.insideAppText(size: 15, weight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
