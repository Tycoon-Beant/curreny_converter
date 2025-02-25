import 'package:flutter/material.dart';

abstract class FontFamily {
  static String get w700 => "Roboto_Condensed_Blod";
  static String get w800 => "Roboto_Condensed_Black";
  static String get w500 => "Roboto_Condensed_Medium";
  static String get w400 => "Roboto_Condensed_Regular";
  static String get w300 => "Roboto_Condensed_Light";
}

extension ThemeGetter on BuildContext {
  TextTheme get theme => Theme.of(this).textTheme;
   ColorScheme get colorScheme => Theme.of(this).colorScheme;
}