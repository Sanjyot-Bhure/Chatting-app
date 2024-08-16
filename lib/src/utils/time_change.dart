import 'package:intl/intl.dart';

String convertTimestampToRealTime(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedTime = DateFormat('d MMM y', 'en_US').format(dateTime);
  return formattedTime;
}
