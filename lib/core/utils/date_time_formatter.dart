import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

String formatDate(DateTime? date, [bool isReminder = false]) {
  final now = DateTime.now();
  if (date == null) {
    return S.current.BUTTON_ADD_DUE_DATE;
  }
  if (date.day == now.day && date.month == now.month) {
    return S.current.calendar_today;
  }
  if (date.day == now.day + 1 && date.month == now.month) {
    return S.current.calendar_tomorrow;
  }
  if (date.year == now.year) {
    if (isReminder) {
      return DateFormat('E, d MMM,').add_jm().format(date).toString();
    } else {
      return DateFormat('E, d MMM').format(date).toString();
    }
  }
  if (isReminder) {
    return DateFormat('E, d MMM y,').add_jm().format(date).toString();
  } else {
    return DateFormat('E, d MMM y').format(date).toString();
  }
}
