import 'package:flutter/material.dart';

Color dueDateColor(DateTime? dueDate) {
  if (dueDate == null) return Colors.white;
  if (dueDate.isBefore(DateTime.now())) return Colors.redAccent;
  if (dueDate.isBefore(DateTime.now().add(const Duration(days: 1)))) {
    return Colors.orange;
  }
  return Colors.white;
}

IconData? dueDateIcon(DateTime? dueDate) {
  if (dueDate == null) return null;
  if (dueDate.isBefore(DateTime.now())) return Icons.warning_amber_outlined;
  if (dueDate.isBefore(DateTime.now().add(const Duration(days: 1)))) {
    return Icons.warning_amber_outlined;
  }
  return Icons.calendar_today_outlined;
}
