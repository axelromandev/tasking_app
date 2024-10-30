import 'package:intl/intl.dart';

class HumanFormat {
  static String time(DateTime? dateTime) {
    if (dateTime == null) return '';
    final String hour =
        (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12).toString();
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  static String datetime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final nowYear = DateTime.now().year;

    if (dateTime.year == nowYear &&
        dateTime.month == DateTime.now().month &&
        dateTime.day == DateTime.now().day) {
      return 'Today';
    }

    if (dateTime.year == nowYear &&
        dateTime.month == DateTime.now().month &&
        dateTime.day == DateTime.now().day + 1) {
      return 'Tomorrow';
    }

    if (dateTime.year == nowYear) {
      return DateFormat('E, MMM d').format(dateTime);
    }
    return DateFormat('E, MMM d y').format(dateTime);
  }
}
