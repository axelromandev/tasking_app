import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/core.dart';
import '../../data/data.dart';

final introProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final user = ref.read(authProvider).user;

  return _Notifier(user);
});

class _Notifier extends StateNotifier<_State> {
  final User? user;

  _Notifier(this.user) : super(_State()) {
    _initialize();
  }

  final groupDataSource = GroupDataSource();
  final pageController = PageController();

  Future<void> _initialize() async {
    final status = await Permission.notification.status;
    state = state.copyWith(isNotificationsGranted: status.isGranted);
  }

  void onNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    state = state.copyWith(currentPage: state.currentPage + 1);
  }

  void onPreviousPage(BuildContext context) {
    if (state.currentPage == 0) {
      context.pop();
      return;
    }
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    state = state.copyWith(currentPage: state.currentPage - 1);
  }

  Future<void> onSignInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      final credential = await googleSignIn.signIn();
      print(credential);
    } catch (e) {
      print(e);
    }
  }

  Future<void> onSignInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );
      print(credential);
    } catch (e) {
      print(e);
    }
  }

  void onAddTaskList(_IntroTaskList e) {
    final taskLists = state.taskLists.toList();
    final suggestionsLists = state.suggestionsLists.toList();
    taskLists.add(e);
    suggestionsLists.remove(e);
    state = state.copyWith(
      taskLists: taskLists,
      suggestionsLists: suggestionsLists,
    );
  }

  void onRemoveTaskList(_IntroTaskList e) {
    final taskLists = state.taskLists.toList();
    final suggestionsLists = state.suggestionsLists.toList();
    taskLists.remove(e);
    suggestionsLists.add(e);
    state = state.copyWith(
      taskLists: taskLists,
      suggestionsLists: suggestionsLists,
    );
  }

  Future<void> onOpenAppSettings() async {
    await openAppSettings();
    _initialize();
  }

  Future<void> onFinish() async {
    if (state.isNotificationsGranted) {
      await _finish();
    } else {
      final status = await Permission.notification.request();
      state = state.copyWith(isNotificationsGranted: status.isGranted);
      if (state.isNotificationsGranted) {
        await _finish();
      }
    }
  }

  Future<void> _finish() async {
    // final group = await groupDataSource.add(
    //   S.current.default_group_1,
    //   BoxIcons.bx_list_ul,
    // );
    // await groupDataSource.add(
    //   S.current.default_group_2,
    //   BoxIcons.bx_cart,
    // );
    // await groupDataSource.add(
    //   S.current.default_group_3,
    //   BoxIcons.bx_briefcase,
    // );
    // await _pref.setKeyValue<int>(Keys.groupId, group.id);
    // await _pref.setKeyValue<bool>(Keys.isFirstTime, false).then((value) {
    //   context.go(RoutesPath.home);
    // });
  }
}

class _State {
  final int currentPage;
  final bool isCloudSyncEnabled;
  final bool isNotificationsGranted;
  final List<_IntroTaskList> taskLists;
  final List<_IntroTaskList> suggestionsLists;

  final List<_IntroSetupItem> items = [
    const _IntroSetupItem(title: 'sync', skip: true),
    const _IntroSetupItem(title: 'lists'),
    const _IntroSetupItem(title: 'notifications'),
  ];

  _State({
    this.currentPage = 0,
    this.isCloudSyncEnabled = false,
    this.isNotificationsGranted = false,
    this.taskLists = const [
      _IntroTaskList(icon: BoxIcons.bx_list_ul, title: 'ToDo', isDefault: true),
    ],
    this.suggestionsLists = const [
      _IntroTaskList(icon: BoxIcons.bx_cart, title: 'Shopping'),
      _IntroTaskList(icon: BoxIcons.bx_briefcase, title: 'Work'),
      _IntroTaskList(icon: BoxIcons.bx_star, title: 'Important'),
    ],
  });

  _State copyWith({
    int? currentPage,
    bool? isCloudSyncEnabled,
    bool? isNotificationsGranted,
    List<_IntroTaskList>? taskLists,
    List<_IntroTaskList>? suggestionsLists,
  }) {
    return _State(
      currentPage: currentPage ?? this.currentPage,
      isCloudSyncEnabled: isCloudSyncEnabled ?? this.isCloudSyncEnabled,
      isNotificationsGranted:
          isNotificationsGranted ?? this.isNotificationsGranted,
      taskLists: taskLists ?? this.taskLists,
      suggestionsLists: suggestionsLists ?? this.suggestionsLists,
    );
  }
}

class _IntroTaskList {
  final IconData icon;
  final String title;
  final bool isDefault;

  const _IntroTaskList({
    required this.icon,
    required this.title,
    this.isDefault = false,
  });
}

class _IntroSetupItem {
  final String title;
  final bool skip;

  const _IntroSetupItem({
    required this.title,
    this.skip = false,
  });
}
