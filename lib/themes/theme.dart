import 'package:flutter/material.dart';

final ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: const Color(
    0xff000721));

var appTheme = ThemeData().copyWith(
  colorScheme: kColorScheme,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10)
    )
  )
);