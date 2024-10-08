import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  primary: Color(0xFFF37D84),
  onPrimary: Colors.white,
  secondary: Color(0xFFF3B0B4),
  onSecondary: Color(0xFF48484C),
  error: Colors.redAccent,
  onError: Colors.white,
  surface: Color(0xFFFAFBFB),
  onSurface: Color(0xFF241E30),
  brightness: Brightness.light,
  shadow: Color(0xFFEAC8CA),
  outline: Color(0xFFF37D84)
);

const  ColorScheme darkColorScheme = ColorScheme(
  primary: Color(0xFFFF8000),
  secondary: Color(0xFF4D1F7C),
  surface: Color(0xFF1F1929),
  error: Colors.redAccent,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  brightness: Brightness.dark,
  shadow: Colors.black12,
  outline: Colors.white
);
