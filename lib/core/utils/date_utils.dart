import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTime(DateTime dateToFormat) {
    return DateFormat('hh:mm a', 'en-US').format(dateToFormat);
  }

  static String formatDate(DateTime dateToFormat) {
    return DateFormat('MM/dd/yy', 'en-US').format(dateToFormat);
  }

  static String formatDateLong(DateTime dateToFormat) {
    return DateFormat('MMMM dd, yyyy', 'en-US').format(dateToFormat);
  }
}
