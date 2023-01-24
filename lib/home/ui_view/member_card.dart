// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:manage_app/utils/manage_theme.dart';

class MemberCard extends StatelessWidget {
  MemberCard({super.key, required this.img_url, required this.name});
  String name;
  String? img_url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ManageTheme.backgroundWhite,
          boxShadow: [
            BoxShadow(
                color: Colors.black26.withOpacity(0.01),
                blurRadius: 2,
                offset: const Offset(1, 1))
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 8,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: ManageTheme.nearlyDarkBlue,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                name,
                style: ManageTheme.appText(
                    size: MediaQuery.of(context).size.width / 35,
                    weight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
    );
  }
}
