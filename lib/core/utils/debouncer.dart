import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 500)});

  final Duration delay;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
