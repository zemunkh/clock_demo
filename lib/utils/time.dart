import 'package:intl/intl.dart';

String prettyTime(DateTime time) => DateFormat('HH:mm').format(time);
String prettyDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
