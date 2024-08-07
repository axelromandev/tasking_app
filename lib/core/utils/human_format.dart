import '../../i18n/generated/translations.g.dart';

class HumanFormat {
  static String datetime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final String hour =
        (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12).toString();
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = dateTime.hour < 12 ? 'AM' : 'PM';
    final String time = '$hour:$minute $period';

    final String day = dateTime.weekday.toString();
    final String month = dateTime.month.toString();
    final String dayStr = S.common.labels.shortDays[int.parse(day) - 1];
    final String monthStr = S.common.labels.shortMonths[int.parse(month) - 1];

    return '$dayStr $day $monthStr, $time';
  }

  static String time(DateTime? dateTime) {
    if (dateTime == null) return '';
    final String hour =
        (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12).toString();
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
