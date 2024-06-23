import 'package:intl/intl.dart';

import '../../generated/strings.g.dart';

String formatDate(DateTime? date, [bool isReminder = false]) {
  final now = DateTime.now();
  if (date == null) {
    return S.button_add_due_date;
  }
  if (date.day == now.day && date.month == now.month) {
    return S.calendar_today;
  }
  if (date.day == now.day + 1 && date.month == now.month) {
    return S.calendar_tomorrow;
  }
  if (date.year == now.year) {
    if (isReminder) {
      return DateFormat('E, d MMM,').add_jm().format(date);
    } else {
      return DateFormat('E, d MMM').format(date);
    }
  }
  if (isReminder) {
    return DateFormat('E, d MMM y,').add_jm().format(date);
  } else {
    return DateFormat('E, d MMM y').format(date);
  }
}
