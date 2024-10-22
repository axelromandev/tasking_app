import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/domain/domain.dart';
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
    state = state.copyWith(typeView: typeView, body: body);
  }

  void onListSelected(ListTasks value) {
    state = state.copyWith(
      typeView: TypeView.lists,
      listSelected: value,
      body: const ListsView(),
    );
  }

  Widget _getBody(TypeView typeView) {
    switch (typeView) {
      case TypeView.search:
        return const Placeholder();
      case TypeView.important:
        return const Placeholder();
      case TypeView.calendar:
        return const CalendarView();
      case TypeView.tasks:
        return const Placeholder();
      default:
        return const HomeView();
    }
  }
}

class _State {
  _State({
    this.typeView = TypeView.home,
    this.body,
    this.listSelected,
  });

  final TypeView typeView;
  final Widget? body;
  final ListTasks? listSelected;

  _State copyWith({
    TypeView? typeView,
    Widget? body,
    ListTasks? listSelected,
  }) {
    return _State(
      typeView: typeView ?? this.typeView,
      body: body ?? this.body,
      listSelected: listSelected,
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
