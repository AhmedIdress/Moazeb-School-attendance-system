import 'package:flutter/material.dart';

class AppColors {
  /*static const Color grey = Colors.grey;
  static const Color white = Colors.white;
  static const Color black = Colors.black;*/
  static Color primary = const Color.fromRGBO(0, 102, 79, 1);
  static Color primaryBright = const Color.fromRGBO(77, 197, 145, 1);
}

final ColorScheme attendanceColorScheme = ColorScheme.light(
  primary: const Color.fromRGBO(0, 102, 79, 1),
  secondary: Colors.blue[700]!,
  background: Colors.white,
  surface: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onBackground: Colors.black,
  onSurface: Colors.black,
  brightness: Brightness.light,
);

final ColorScheme attendanceDarkColorScheme = ColorScheme.dark(
  primary: Colors.green[700]!,
  secondary: Colors.blue[800]!,
  background: Colors.grey[900]!,
  surface: Colors.grey[900]!,
  onPrimary: Colors.grey[900]!,
  onSecondary: Colors.grey[900]!,
  onBackground: Colors.white,
  onSurface: Colors.white,
  brightness: Brightness.dark,
);
