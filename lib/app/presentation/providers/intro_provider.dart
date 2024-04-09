import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/data.dart';

final introProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
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

  final List<IntroSetupItem> items = [
    IntroSetupItem(title: 'sync', skip: true),
    IntroSetupItem(title: 'lists'),
    IntroSetupItem(title: 'notifications'),
  ];

  _State({
    this.currentPage = 0,
    this.isCloudSyncEnabled = false,
    this.isNotificationsGranted = false,
  });

  _State copyWith({
    int? currentPage,
    bool? isCloudSyncEnabled,
    bool? isNotificationsGranted,
  }) {
    return _State(
      currentPage: currentPage ?? this.currentPage,
      isCloudSyncEnabled: isCloudSyncEnabled ?? this.isCloudSyncEnabled,
      isNotificationsGranted:
          isNotificationsGranted ?? this.isNotificationsGranted,
    );
  }
}

class IntroSetupItem {
  final String title;
  final bool skip;

  IntroSetupItem({
    required this.title,
    this.skip = false,
  });
}
