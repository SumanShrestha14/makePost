import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade500,
    secondary: const Color.fromARGB(255, 34, 34, 34),
    tertiary: const Color.fromARGB(255, 0, 0, 0),
    inversePrimary: Colors.grey.shade300,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
);
