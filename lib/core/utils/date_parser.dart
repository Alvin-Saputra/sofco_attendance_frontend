import 'package:intl/intl.dart';

class DateParser {
  const DateParser._();

  static DateTime stringToDate(String value, {
    String? pattern,
    bool toLocal = true,
  }) {
     DateTime date;

    if (pattern == null) {
      // ISO 8601
      date = DateTime.parse(value);
    } else {
      // Custom format
      date = DateFormat(pattern).parse(value);
    }

    return toLocal ? date.toLocal() : date;
  }


  static String  dateToString(
    DateTime date, {
    String pattern = 'yyyy-MM-dd',
  }) {
    return DateFormat(pattern).format(date);
  }

  
}