import 'package:intl/intl.dart';

class TimeUtils {
  static final dateFormat = DateFormat('dd/MM/yyyy');
  static tomorrow() => DateTime.now().add(const Duration(days: 1));
  static theDayAfterTomorrow() => DateTime.now().add(const Duration(days: 2));
  static String convertTempDate(int timeInMillis, String style) {
    var date = DateTime.fromMicrosecondsSinceEpoch(timeInMillis * 1000000);
    var formattedDate = DateFormat(style).format(date);
    return formattedDate;
  }

  static String? convertDateTime(DateTime? value, String? style) {
    var convertTime = DateFormat(style).format(value!).toString();
    return convertTime;
  }
}
