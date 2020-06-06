import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/main_screen.dart';
import './models/theme.dart';

bool activated = false;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 

    return ChangeNotifierProvider<ThemeProvider>(
      builder: (_) => ThemeProvider(false),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Mesamis Client App',
      home: MainScreen(),
      theme: theme.getThemeData,
    );
  }
}