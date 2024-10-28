import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/presentation/calendar/calendar.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/lists/lists.dart';

final homeProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void onChangeView(TypeView typeView) {
    final body = _getBody(typeView);
    state = state.copyWith(
      typeView: typeView,
      body: body,
    );
  }

  void onListSelected(int listId) {
    state = state.copyWith(
      typeView: TypeView.lists,
      listId: listId,
      body: ListTasksView(listId),
    );
    scaffoldKey.currentState?.closeDrawer();
  }

  Widget _getBody(TypeView typeView) {
    switch (typeView) {
      case TypeView.important:
        return const ImportantView();
      case TypeView.calendar:
        return const CalendarView();
      case TypeView.tasks:
        return const ListTasksView(1);
      default:
        return const MyDayView();
    }
  }
}

class _State {
  _State({
    this.typeView = TypeView.home,
    this.body,
    this.listId,
  });

  final TypeView typeView;
  final Widget? body;
  final int? listId;

  _State copyWith({
    TypeView? typeView,
    Widget? body,
    int? listId,
  }) {
    return _State(
      typeView: typeView ?? this.typeView,
      body: body ?? this.body,
      listId: listId,
    );
  }
}

enum TypeView {
  search,
  home,
  important,
  calendar,
  tasks,
  lists,
}
