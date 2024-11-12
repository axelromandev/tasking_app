import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void onChangeView(TypeView typeView) {
    state = state.copyWith(
      typeView: typeView,
    );
  }

  void onListSelected(int listId) {
    state = state.copyWith(
      typeView: TypeView.lists,
      listId: listId,
    );
    scaffoldKey.currentState?.closeDrawer();
  }
}

class _State {
  _State({
    this.typeView = TypeView.home,
    this.listId,
  });

  final TypeView typeView;
  final int? listId;

  _State copyWith({
    TypeView? typeView,
    int? listId,
  }) {
    return _State(
      typeView: typeView ?? this.typeView,
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
