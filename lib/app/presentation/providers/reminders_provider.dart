import 'package:flutter_riverpod/flutter_riverpod.dart';

final remindersProvider =
    StateNotifierProvider.autoDispose<RemindersNotifier, RemindersState>((ref) {
  return RemindersNotifier();
});

class RemindersNotifier extends StateNotifier<RemindersState> {
  RemindersNotifier() : super(RemindersState());
}

class RemindersState {}
