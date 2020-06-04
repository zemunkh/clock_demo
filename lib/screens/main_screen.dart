import 'package:flutter/material.dart';
import '../clock/analog_clock.dart';
import '../widgets/weather_view.dart';
import '../widgets/calendar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WeatherView(),
              Calendar(),
              AnalogClock(
                isLive: true,
                showSecondHand: true,
                showAllNumbers: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

