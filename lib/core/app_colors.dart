import 'package:flutter/material.dart';

/*class AppColors{
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const primary = Colors.blue;
}*/

final ColorScheme attendanceColorScheme = ColorScheme.light(
  primary: Colors.green,
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

