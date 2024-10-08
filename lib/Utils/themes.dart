import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'color_scheme.dart';

class MyAppTheme {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static final ThemeData lightTheme =
      themeData(lightColorScheme, _lightFocusColor);
  static final ThemeData darkTheme =
      themeData(darkColorScheme, _darkFocusColor);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      focusColor: focusColor,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        centerTitle: true,
        titleSpacing: 2,
        toolbarHeight: 50,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
      ),


      elevatedButtonTheme: ElevatedButtonThemeData(

        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
          side: const BorderSide(
            color: Colors.white,
            width: 2
          ),
          padding: EdgeInsets.symmetric(vertical: 15,horizontal:20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

          )

        ),
      ),



      inputDecorationTheme: InputDecorationTheme(

        fillColor: colorScheme.secondary,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),

        labelStyle: TextStyle(color: colorScheme.onSecondary, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      iconTheme:const IconThemeData(color: Colors.white),
    );
  }
}
