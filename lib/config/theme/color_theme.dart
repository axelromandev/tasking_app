import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';

final colorThemeProvider = StateNotifierProvider<_Notifier, Color>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<Color> {
  _Notifier() : super(Colors.amber) {
    initialize();
  }

  final _pref = SharedPrefs();

  final List<ThemeColor> colors = [
    const ThemeColor(
      name: 'Red Orange',
      value: Colors.red,
    ),
    const ThemeColor(
      name: 'Razzmatazz',
      value: Colors.pink,
    ),
    const ThemeColor(
      name: 'Violet Eggplant',
      value: Colors.purple,
    ),
    const ThemeColor(
      name: 'Purple Heart',
      value: Colors.deepPurple,
    ),
    const ThemeColor(
      name: 'Governor Bay',
      value: Colors.indigo,
    ),
    const ThemeColor(
      name: 'Dodger Blue',
      value: Colors.blue,
    ),
    const ThemeColor(
      name: 'Cerulean',
      value: Colors.lightBlue,
    ),
    const ThemeColor(
      name: "Robin's Egg Blue",
      value: Colors.cyan,
    ),
    const ThemeColor(
      name: 'Gossamer',
      value: Colors.teal,
    ),
    const ThemeColor(
      name: 'Fruit Salad',
      value: Colors.green,
    ),
    const ThemeColor(
      name: 'Sushi',
      value: Colors.lightGreen,
    ),
    const ThemeColor(
      name: 'Pear',
      value: Colors.lime,
    ),
    const ThemeColor(
      name: 'Gorse',
      value: Colors.yellow,
    ),
    const ThemeColor(
      name: 'Amber',
      value: Colors.amber,
    ),
    const ThemeColor(
      name: 'California',
      value: Colors.orange,
    ),
    const ThemeColor(
      name: 'Orange',
      value: Colors.deepOrange,
    ),
    const ThemeColor(
      name: 'Roman Coffee',
      value: Colors.brown,
    ),
    const ThemeColor(
      name: 'Smalt Blue',
      value: Colors.blueGrey,
    ),
    const ThemeColor(
      name: 'Martini',
      value: Colors.grey,
    ),
  ];

  void initialize() {
    final colorValue = _pref.getValue<int>(StorageKeys.colorSeed);
    if (colorValue == null) return;
    state = Color(colorValue);
  }

  Future<void> setColor(Color color) async {
    if (color.value == state.value) return;
    await _pref.setKeyValue<int>(StorageKeys.colorSeed, color.value);
    state = color;
  }
}

class ThemeColor {
  const ThemeColor({
    required this.name,
    required this.value,
  });

  final String name;
  final Color value;
}
