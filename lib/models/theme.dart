import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {

  bool isDarkTheme;

  ThemeProvider(this.isDarkTheme);

  ThemeData get getThemeData => isDarkTheme ? darkTheme : lightTheme;

  bool get getThemeStatus => isDarkTheme;
  
  setThemeData(bool val) {

    (val) ? isDarkTheme = true : isDarkTheme = false;

    notifyListeners();
  }
}

void onThemeChanged(bool value, ThemeProvider themeNotifier) async {
  (value) ? themeNotifier.setThemeData(true)
          : themeNotifier.setThemeData(false);
  
  var prefs = await SharedPreferences.getInstance();
  prefs.setBool('darkMode', value);
}


final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: Color(0xFF000000),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black54,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);