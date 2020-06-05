import 'package:clock_demo/clock/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../clock/analog_clock.dart';
import '../widgets/weather_view.dart';
import '../widgets/calendar.dart';
import '../models/theme.dart';

class MainScreen extends StatelessWidget {


  _buildMainLayout(Orientation deviceOrientation, ThemeChanger _themeChanger) {
    if(deviceOrientation == Orientation.portrait) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WeatherView(),
            Calendar(),
            AnalogClock(
              isLive: true,
              showSecondHand: true,
              showAllNumbers: true,
            ),
            DigitalClock(
              isLive: true,
            ),
            FlatButton(
              child: Text('Dark Theme'),
              onPressed: () => _themeChanger.setTheme(ThemeData.dark())
            ),
            FlatButton(
              child: Text('Light Theme'),
              onPressed: () => _themeChanger.setTheme(ThemeData.light())
            ),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            WeatherView(),
            Calendar(),
            AnalogClock(
              isLive: true,
              showSecondHand: true,
              showAllNumbers: true,
            ),
            DigitalClock(
              isLive: true,
            ),
            FlatButton(
              child: Text('Dark Theme'),
              onPressed: () => _themeChanger.setTheme(darkTheme)
            ),
            FlatButton(
              child: Text('Light Theme'),
              onPressed: () => _themeChanger.setTheme(lightTheme)
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    final layout = Center(
      child: _buildMainLayout(MediaQuery.of(context).orientation, _themeChanger),
    );

    return Scaffold(
      body: layout,
    );
  }
}

