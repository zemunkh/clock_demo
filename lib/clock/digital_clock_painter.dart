import 'package:flutter/material.dart';

class DigitalClockPainter extends CustomPainter {
  DateTime datetime;
  final bool showTicks;
  final int digitalClockColor;
  final Color numberColor;
  final double textScaleFactor;

  static const double BASE_SIZE = 320.0;
  static const double MINUTES_IN_HOUR = 60.0;
  static const double SECONDS_IN_MINUTE = 60.0;
  static const double HOURS_IN_CLOCK = 12.0;
  static const double HAND_PIN_HOLE_SIZE = 8.0;
  static const double STROKE_WIDTH = 4.0;

  DigitalClockPainter(
      {@required this.datetime,
      this.showTicks = true,
      this.digitalClockColor = 0xFF262269,
      this.numberColor = Colors.black,
      this.textScaleFactor = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    double scaleFactor = size.shortestSide / BASE_SIZE;

    _paintDigitalClock(canvas, size, scaleFactor);
  }

  @override
  bool shouldRepaint(DigitalClockPainter oldDelegate) {
    return oldDelegate?.datetime?.isBefore(datetime) ?? true;
  }


  // ref: https://www.codenameone.com/blog/codename-one-graphics-part-2-drawing-an-analog-clock.html

  void _paintDigitalClock(Canvas canvas, Size size, double scaleFactor) {
    String hour = datetime.hour.toString().padLeft(2, "0");
    String minute = datetime.minute.toString().padLeft(2, "0");
    // String second = datetime.second.toString().padLeft(2, "0");

    List<Shadow> dititShadows = [
      Shadow(
        blurRadius: 120,
        color: Colors.black.withOpacity(0.1),
        offset: Offset(0, 0),
      ),
      Shadow(
        blurRadius: 60,
        color: Colors.black.withOpacity(0.2),
        offset: Offset(0, 0),
      ),
    ];

    TextSpan digitalClockSpan = new TextSpan(
        style: TextStyle(
            color: Color(digitalClockColor),
            fontFamily: 'Rubik',
            fontSize: 160 * scaleFactor * textScaleFactor,
            shadows: dititShadows,            
            ),
        text: "$hour:$minute"
    );

    TextPainter digitalClockTP = new TextPainter(
        text: digitalClockSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    digitalClockTP.layout();
    digitalClockTP.paint(
        canvas,
        size.center(
            -digitalClockTP.size.center(Offset(0.0, 0.0))));
  }
}