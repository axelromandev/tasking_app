import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: CalendarView Implement build method.
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendario',
          style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: const Center(child: Text('CalendarView')),
    );
  }
}
