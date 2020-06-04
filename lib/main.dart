import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import './screens/main_screen.dart';

bool activated = false;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 

    return MaterialApp(
        title: 'Mesamis Client App',
        theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        home: MainScreen(),
      );
  }
}
