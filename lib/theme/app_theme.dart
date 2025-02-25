import 'package:curreny_converter/converter/config/common.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.blue,
        onSecondary: Color(0xff808080),
        tertiary: Color.fromARGB(255, 240, 240, 240),
        onTertiary:Colors.white,
         outline: Color(0xff333333)
        ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xfff8f8f8),
    textTheme:
        textTheme.apply(displayColor: Colors.black, bodyColor: Colors.black),
    primaryColor: Colors.black,
    useMaterial3: true,
    fontFamily: "Roboto_Condensed_Regular",
    appBarTheme: AppBarTheme(
      backgroundColor:Colors.white,
      surfaceTintColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontFamily: FontFamily.w700,
        ),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.black; // Thumb color when the switch is ON
        }
        return Colors.grey; // Thumb color when the switch is OFF
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.black
              .withOpacity(0.5); // Track color when the switch is ON
        }
        return Colors.grey
            .withOpacity(0.5); // Track color when the switch is OFF
      }),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    chipTheme: ChipThemeData(
     
      shape: const StadiumBorder(side: BorderSide(color: Color(0xff808080),),),
    ),
  );

  
  static final textTheme = Typography.englishLike2021.copyWith(
    headlineSmall: TextStyle(fontSize: 28, fontFamily: FontFamily.w700),
    titleMedium: TextStyle(fontFamily: FontFamily.w700),
  );
}
