import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class JimColors {
  static const Color primary = Color(0xFF4ADE80);
  static const Color backgroundAccent = Color(0xFFEDEDED);
  static const Color white = Colors.white;
  static const Color placeholder = Color(0xFFCCCCCC);
  static const Color stroke = Color(0xFFAEAEB2);
  
  static const Color error = Color(0xFFEE3B2B);
  static const Color success = Color(0xFF82DD55);
  static const Color warning = Color(0xFFFAC752);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF737373);
}


class JimTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: JimColors.textPrimary,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: JimColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: JimColors.textPrimary,
  );

  static const TextStyle subBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: JimColors.textPrimary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: JimColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: JimColors.white,
  );
}


class JimSpacings {
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 40;

  static const double radius = 16;
  static const double radiusLarge = 24;
  static const double iconSize = 24;
  static const double buttonHeight = 48;
}
class JimIconSizes {
  static const double small = 20;
  static const double medium = 24;
  static const double large = 32;
}

ThemeData appTheme =  ThemeData(
  fontFamily: 'Eesti',
  scaffoldBackgroundColor: Colors.white,
);
