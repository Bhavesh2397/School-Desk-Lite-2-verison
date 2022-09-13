import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
      );
}

class BaseConfig {
  static String webURL = "https://test.rbkei.org/mobile/toweb?token=";
  static String baseUrl = "https://mtestsd.rbkei.in/";
  static String secondarybaseUrl = "https://sdapi.schooldesk.org/";
}
