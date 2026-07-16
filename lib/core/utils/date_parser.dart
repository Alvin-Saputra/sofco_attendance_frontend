class DateParser {
  const DateParser._();

  static DateTime fromString(String value) {
    return DateTime.parse(value);
  }

  static String dateTimeToString(DateTime date) {
    return date.toIso8601String();
  }
}