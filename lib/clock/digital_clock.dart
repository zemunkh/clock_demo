import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import './digital_clock_painter.dart';


class DigitalClock extends StatefulWidget {
  final DateTime datetime;
  final Color numberColor;
  final bool isLive;
  final double textScaleFactor;
  final double width;
  final double height;
  final BoxDecoration decoration;

  const DigitalClock(
      {this.datetime,
      this.numberColor = Colors.black,
      this.textScaleFactor = 1.0,
      this.width = 320,
      this.height = 320,
      this.decoration = const BoxDecoration(),
      isLive,
      Key key})
      : this.isLive = isLive ?? (datetime == null),
        super(key: key);

  const DigitalClock.dark(
      {datetime,
      showDigitalClock = true,
      showTicks = true,
      showNumbers = true,
      showAllNumbers = false,
      showSecondHand = true,
      width = double.infinity,
      height = double.infinity,
      decoration = const BoxDecoration(),
      Key key})
      : this(
            datetime: datetime,
            width: width,
            height: height,
            numberColor: Colors.white,
            decoration: decoration,
            key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState(datetime);
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime datetime;

  _DigitalClockState(datetime) : this.datetime = datetime ?? DateTime.now();

  initState() {
    super.initState();
    if (widget.isLive) {
      // update clock every second or minute based on second's flashing visibility.
      Duration updateDuration = Duration(seconds: 1);
      Timer.periodic(updateDuration, update);
    }
  }

  update(Timer timer) {
    if (mounted) {
      // update is only called on live clocks. So, it's safe to update datetime.
      datetime = DateTime.now();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      child: Center(
        child: AspectRatio(
          aspectRatio: 5 / 3,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final borderRadius =
                  constraints.biggest.width * 0.09;
              final borderWidth =
                  constraints.biggest.width * 0.03;
              return Container(
                color: Colors.white,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(borderRadius),
                  border: Border.all(
                      width: borderWidth,
                      color: Colors.black87,
                      style: BorderStyle.solid),
                  boxShadow: [BoxShadow(
                    offset: const Offset(10, 10),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: Color.fromARGB(50, 148, 148, 148)
                  )]
                ),
                child: ClipRRect(
                  child: new CustomPaint(
                    painter: new DigitalClockPainter(
                      datetime: datetime,
                      textScaleFactor: widget.textScaleFactor,
                      numberColor: widget.numberColor
                    ),
                  ),
                  borderRadius: BorderRadius.circular(
                      borderRadius - borderWidth),
                ),
              );
            },
          )
        )
      )
    );
  }
}