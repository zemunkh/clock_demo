import 'package:flutter/material.dart';
import 'dart:async';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  var date = DateTime.now();
  String month = '1';
  String day = '1';
  String weekday = 'Sunday';
  List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  List<String> months = ['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'];

  _updateDate() {
    setState(() {
      month = months[date.month - 1].toUpperCase();
      day = date.day.toString();
      weekday = weekdays[date.weekday - 1];
    });
  }
  @override
  void initState() {
    super.initState();
    _updateDate();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(10),
          ),
          side: BorderSide(width: 0, color: Colors.black), 
        ),
        shadows: [BoxShadow(
          offset: const Offset(10, 10),
          blurRadius: 4,
          spreadRadius: 0,
          color: Color.fromARGB(50, 148, 148, 148)
        )]
      ),
      child: Column(
        children: <Widget>[
          Text(
            month,
            style: TextStyle(
              fontSize: 36,
              fontFamily: 'Montserrat',
              color: Color(0xFFFF2D55)
            ),
          ),
          Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 140,
                fontFamily: 'Montserrat',
                color: Color(0xFF262269)
              ),
            ),
          ),
          Text(
            weekday,
            style: TextStyle(
              fontSize: 36,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Color(0xFF007AFF)
            ),
          ),
        ],
      ),
    );
  }
}
