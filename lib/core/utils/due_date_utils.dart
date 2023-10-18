import 'package:flutter/material.dart';
import 'package:tasking/config/config.dart';

Color dueDateColor(DateTime? dueDate) {
  final context = navigatorKey.currentContext!;
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  if (dueDate == null) return isDarkMode ? Colors.white : Colors.black;
  if (dueDate.isBefore(DateTime.now())) return Colors.redAccent;
  if (dueDate.isBefore(DateTime.now().add(const Duration(days: 1)))) {
    return Colors.orange;
  }
  return isDarkMode ? Colors.white : Colors.black;
}

IconData? dueDateIcon(DateTime? dueDate) {
  if (dueDate == null) return null;
  if (dueDate.isBefore(DateTime.now())) return Icons.warning_amber_outlined;
  if (dueDate.isBefore(DateTime.now().add(const Duration(days: 1)))) {
    return Icons.warning_amber_outlined;
  }
  return Icons.calendar_today_outlined;
}
