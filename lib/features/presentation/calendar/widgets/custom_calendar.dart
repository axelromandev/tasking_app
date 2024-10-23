import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class CustomCalendar extends ConsumerStatefulWidget {
  const CustomCalendar({
    required this.selectedDate,
    required this.onSelectedDate,
  });

  final DateTime selectedDate;
  final Function(DateTime) onSelectedDate;

  @override
  ConsumerState<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends ConsumerState<CustomCalendar> {
  DateTime _currentDate = DateTime.now();
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.selectedDate;
    super.initState();
  }

  // Genera una matriz de días para el mes actual
  List<List<DateTime?>> _generateCalendarMatrix(DateTime month) {
    final List<List<DateTime?>> matrix = [];

    // Primer día del mes
    final DateTime firstDayOfMonth = DateTime(month.year, month.month);
    // Último día del mes
    final DateTime lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    // Día de la semana del primer día del mes (domingo = 0, lunes = 1, ..., sábado = 6)
    final int firstWeekday =
        firstDayOfMonth.weekday % 7; // Convertir a 0=Dom, 1=Lun, ..., 6=Sáb

    // Total de días en el mes
    final int totalDays = lastDayOfMonth.day;

    // Calcula el número de semanas necesarias
    final int totalSlots = firstWeekday + totalDays;
    final int totalWeeks = (totalSlots / 7).ceil();

    for (int week = 0; week < totalWeeks; week++) {
      final List<DateTime?> weekDays = [];
      for (int day = 0; day < 7; day++) {
        final int dayNumber = week * 7 + day - firstWeekday + 1;
        if (dayNumber > 0 && dayNumber <= totalDays) {
          weekDays.add(DateTime(month.year, month.month, dayNumber));
        } else {
          weekDays.add(null);
        }
      }
      matrix.add(weekDays);
    }

    return matrix;
  }

  bool isNotEqualDateTime(DateTime date1, DateTime date2) {
    return date1.year != date2.year &&
        date1.month != date2.month &&
        date1.day != date2.day;
  }

  // Función para ir al mes anterior
  void _goToPreviousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
  }

  // Función para ir al mes siguiente
  void _goToNextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
  }

  // Función para seleccionar una fecha
  void _onSelectedDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      widget.onSelectedDate(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarMatrix = _generateCalendarMatrix(_currentDate);
    final String monthYear = DateFormat.yMMMM().format(_currentDate);

    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(IconsaxOutline.arrow_left_2),
              onPressed: _goToPreviousMonth,
            ),
            Text(monthYear, style: style.titleLarge),
            IconButton(
              icon: const Icon(IconsaxOutline.arrow_right_3),
              onPressed: _goToNextMonth,
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: S.common.labels.calendarDays
              .map(
                (day) => Expanded(
                  child: Center(child: Text(day)),
                ),
              )
              .toList(),
        ),
        const Gap(10),
        // Matriz de días
        Column(
          children: calendarMatrix.map((week) {
            return Row(
              children: week.map((day) {
                final bool isToday = day != null &&
                    day.year == DateTime.now().year &&
                    day.month == DateTime.now().month &&
                    day.day == DateTime.now().day;

                final bool isSelected = day != null &&
                    day.year == _selectedDate.year &&
                    day.month == _selectedDate.month &&
                    day.day == _selectedDate.day;

                return Expanded(
                  child: GestureDetector(
                    onTap: day != null ? () => _onSelectedDate(day) : null,
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.all(2),
                      decoration: (day != null)
                          ? isSelected
                              ? BoxDecoration(
                                  color: colorPrimary,
                                  borderRadius: BorderRadius.circular(8),
                                )
                              : isToday
                                  ? BoxDecoration(
                                      color: colorPrimary.withOpacity(0.1),
                                      border: Border.all(color: colorPrimary),
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                  : BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(8),
                                    )
                          : BoxDecoration(
                              color: Colors.white.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(8),
                            ),
                      child: Center(
                        child: Text(
                          (day != null) ? '${day.day}' : '',
                          style: style.bodyLarge?.copyWith(
                            color: isSelected
                                ? Colors.black
                                : isToday
                                    ? colorPrimary
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
