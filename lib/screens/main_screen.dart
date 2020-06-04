import 'package:flutter/material.dart';
import '../clock/analog_clock.dart';
import '../widgets/weather_view.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WeatherView(),
            AnalogClock(
              isLive: true,
              showSecondHand: true,
              showAllNumbers: true,
            )
          ],
        ),
      ),
    );
  }
}

