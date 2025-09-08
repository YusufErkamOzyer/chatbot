import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampUtil {
  static String formatTimestampHour(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  static String formatTimestampDateddMMyyyy(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
  }

  static String formatTimestampDay(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return _weekdayName(dateTime.weekday);
  }

  static String _weekdayName(int weekday) {
    const names = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return names[weekday - 1];
  }
}
