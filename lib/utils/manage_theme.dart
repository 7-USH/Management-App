import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:manage_app/utils/error_page.dart';
import 'dart:math' as math;

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ManageTheme {
  ManageTheme._();

  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xff121212);
  static const Color nearlyDarkBlue = Color(0xff5F4FD0);
  static const Color successGreen = Color(0xff4BB543);
  static const Color nearlyGrey = Color(0xffEBEBEC);

  // ignore: constant_identifier_names
  static const String MANAGE_DB_LINK =
      "https://fastapi-soumitrakand7.cloud.okteto.net/";

  // ignore: constant_identifier_names
  static const String API_VERSION = "api/v1/";

  static TextStyle appText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = nearlyBlack,
    bool isShadow = false,
  }) {
    return GoogleFonts.lato(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static TextStyle insideAppText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = nearlyBlack,
    bool isShadow = false,
  }) {
    return GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static ButtonStyle buttonStyle(
      {double fontSize = 10,
      FontWeight weight = FontWeight.bold,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.transparent}) {
    return ElevatedButton.styleFrom(
        textStyle: appText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: BorderSide(color: borderColor)));
  }

  static InputDecoration faInputDecoration(
      {String? hint,
      Color? bgColor,
      double fontSize = 20,
      Color? borderColor,
      EdgeInsets? padding}) {
    return InputDecoration(
      contentPadding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      counter: const Offstage(),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor ?? nearlyBlack)),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      labelText: hint,
      fillColor: Colors.transparent,
      floatingLabelStyle: appText(
          size: fontSize, weight: FontWeight.normal, color: nearlyBlack),
      labelStyle: appText(
          size: fontSize, weight: FontWeight.normal, color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: appText(size: fontSize, weight: FontWeight.normal),
      filled: true,
    );
  }

  static InputDecoration waInputDecoration(
      {IconData? prefixIcon,
      String? hint,
      Color? bgColor,
      double fontSize = 20,
      Color? borderColor,
      EdgeInsets? padding}) {
    return InputDecoration(
      contentPadding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      counter: const Offstage(),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: nearlyBlack)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor ?? nearlyBlack)),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      fillColor: bgColor ?? nearlyBlack.withOpacity(0.04),
      hintText: hint,
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: nearlyBlack) : null,
      hintStyle: appText(size: fontSize, weight: FontWeight.normal),
      filled: true,
    );
  }

  static moveToError({required BuildContext context, required String text}) {
    PersistentNavBarNavigator.pushNewScreen(context,
        screen: ErrorPage(text: text),withNavBar: false);
  }

  static int generateOTP() {
    var rnd = math.Random();
    var next = rnd.nextDouble() * 1000;
    while (next < 1000) {
      next *= 10;
    }
    return next.toInt();
  }
}
