import 'package:intl/intl.dart';

class AppFormat {
  static String dateDDMMYY(DateTime date) {
    String formattedDate = DateFormat('dd-MM-yy, hh:mm').format(date);
    return formattedDate;
  }

  static String dateYYMMDD(DateTime date) {
    String formattedDate = DateFormat('yy-MM-dd').format(date);
    return formattedDate;
  }

  static String dateMonthOnly(DateTime date) {
    String formattedDate = DateFormat('dd MMMM').format(date);
    return formattedDate;
  }

  static String ddMMM12h(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd MMM, hh:mm a').format(dateTime);
  }

  static String hhmmDifference(DateTime? dateTime) {
    if (dateTime == null) return '';
    return "${DateTime.now().difference(dateTime).inHours}:${DateTime.now().difference(dateTime).inMinutes.remainder(60)}";
  }

  static String? doubleToStringUpTo2(String? number) {
    if (number == null) return null;
    return double.tryParse(number)?.toStringAsFixed(2);
  }
}
