import 'package:clock_demo/clock/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../clock/analog_clock.dart';
import '../widgets/weather_view.dart';
import '../widgets/calendar.dart';
import '../models/theme.dart';

class MainScreen extends StatelessWidget {

  _buildMainLayout(Orientation deviceOrientation, ThemeProvider _themeProvider) {
    if(deviceOrientation == Orientation.portrait) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WeatherView(),
            Calendar(),
            (_themeProvider.isDarkTheme) ? darkClock : lightClock,
            DigitalClock(
              isLive: true,
            ),
            FlatButton(
              child: Text('Dark Theme'),
              onPressed: () => _themeProvider.setThemeData(true)
            ),
            FlatButton(
              child: Text('Light Theme'),
              onPressed: () => _themeProvider.setThemeData(false)
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
              onPressed: () => _themeProvider.setThemeData(true)
            ),
            FlatButton(
              child: Text('Light Theme'),
              onPressed: () => _themeProvider.setThemeData(false)
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    final layout = Center(
      child: _buildMainLayout(MediaQuery.of(context).orientation, _themeProvider),
    );

    return Scaffold(
      body: layout,
    );
  }

  Widget get darkClock => AnalogClock(
    width: 250.0,
    datetime: DateTime.now(),
    key: GlobalObjectKey(1),
    decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    hourHandColor: Colors.white,
    minuteHandColor: Colors.white,
    numberColor: Colors.white,
    showSecondHand: true,
    showAllNumbers: true,
  );


  Widget get lightClock => AnalogClock(
      isLive: true,
      showSecondHand: true,
      showAllNumbers: true,
    );
}

