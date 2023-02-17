import 'package:flutter/material.dart';

var mainTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.blue,
  brightness: Brightness.light,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
  ),
);
