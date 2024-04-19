import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../providers/intro_provider.dart';
import '../widgets/widgets.dart';

class IntroSetupPage extends ConsumerWidget {
  const IntroSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: IntroSetupPage Implement build method.

    final provider = ref.watch(introProvider);
    final notifier = ref.read(introProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            height: 10,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const Gap(4),
              itemCount: 3,
              itemBuilder: (_, index) => Container(
                width: defaultPadding,
                decoration: BoxDecoration(
                  color: index == provider.currentPage
                      ? Colors.white
                      : Colors.white12,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const Gap(defaultPadding),
        ],
        leading: IconButton(
          onPressed: () => notifier.onPreviousPage(context),
          icon: const Icon(BoxIcons.bx_arrow_back),
        ),
      ),
      body: PageView(
        controller: notifier.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _IntroCloudSync(),
          _IntroTaskLists(),
          _IntroNotifications(),
        ],
      ),
    );
  }
}

class _IntroNotifications extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final provider = ref.watch(introProvider);
    final notifier = ref.read(introProvider.notifier);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications',
                style: style.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.primary,
                )),
            const Gap(defaultPadding),
            Text(
              'Receive notifications for due dates, reminders, and priority levels.',
              style: style.bodyLarge,
            ),
            const Gap(defaultPadding * 2),
            Text(
              'Example',
              style: style.bodyLarge,
            ),
            const Gap(defaultPadding),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              tileColor: Colors.white.withOpacity(0.06),
              iconColor: colors.primary,
              leading: const Icon(BoxIcons.bx_bell),
              title: const Text('Task Reminder'),
              subtitle: Text('Task: Finish the project',
                  style: style.bodySmall?.copyWith(
                    color: Colors.white70,
                  )),
              trailing: Text('Today, 9:00 AM',
                  style: style.bodySmall?.copyWith(
                    color: Colors.white70,
                  )),
            ),
            const Gap(defaultPadding),
            if (!provider.isNotificationsGranted)
              Text.rich(TextSpan(
                text: 'You have denied the notification permission. ',
                style: style.bodyMedium?.copyWith(color: Colors.redAccent),
                children: [
                  TextSpan(
                    text: 'Please enable it in the settings.',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.redAccent,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = notifier.onOpenAppSettings,
                  ),
                ],
              )),
            const Spacer(),
            Text(
              'Without this permission the app may not work correctly or as you expect.',
              style: style.bodyLarge,
            ),
            CustomFilledButton(
              margin: const EdgeInsets.only(top: defaultPadding),
              onPressed: notifier.onFinish,
              textStyle: style.bodyLarge,
              child: const Text('Continue'),
            )
          ],
        ),
      ),
    );
  }
}

class _IntroTaskLists extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final provider = ref.watch(introProvider);
    final notifier = ref.read(introProvider.notifier);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 28, right: 28, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('List of Tasks',
                style: style.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.primary,
                )),
            const Gap(defaultPadding),
            Text(
              'Create, edit, and delete tasks. Set due dates, reminders, and priority levels.',
              style: style.bodyLarge,
            ),
            const Gap(defaultPadding * 2),
            Text(
              'Selected List',
              style: style.bodyLarge,
            ),
            const Gap(defaultPadding),
            ...provider.taskLists.map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: defaultPadding),
                child: ListTile(
                  onTap:
                      e.isDefault ? null : () => notifier.onRemoveTaskList(e),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  tileColor: Colors.white.withOpacity(0.06),
                  iconColor: colors.primary,
                  leading: Icon(e.icon),
                  title: Text(e.title),
                  trailing: e.isDefault
                      ? Text('Default',
                          style: style.bodySmall?.copyWith(
                            color: Colors.white70,
                          ))
                      : Text('Remove',
                          style: style.bodySmall?.copyWith(
                            color: Colors.redAccent,
                          )),
                ),
              ),
            ),
            const Gap(defaultPadding),
            if (provider.suggestionsLists.isNotEmpty)
              Text(
                'Suggestions List',
                style: style.bodyLarge,
              ),
            const Gap(defaultPadding),
            ...provider.suggestionsLists.map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: defaultPadding),
                child: ListTile(
                  onTap: () => notifier.onAddTaskList(e),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  tileColor: Colors.white.withOpacity(0.06),
                  iconColor: colors.primary,
                  leading: Icon(e.icon),
                  title: Text(e.title),
                  trailing: Text('Add',
                      style: style.bodySmall?.copyWith(
                        color: colors.primary,
                      )),
                ),
              ),
            ),
            const Spacer(),
            CustomFilledButton(
              margin: const EdgeInsets.only(top: defaultPadding),
              onPressed: notifier.onNextPage,
              textStyle: style.bodyLarge,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroCloudSync extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 28, right: 28, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cloud Sync',
                style: style.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.primary,
                )),
            const Gap(defaultPadding),
            Text(
              'Sync your tasks across all devices, anywhere, anytime. Offline support included.',
              style: style.bodyLarge,
            ),
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/svg/undraw_cloud_sync.svg',
                height: 260,
              ),
            ),
            const Spacer(),
            _ActionsButtons(),
          ],
        ),
      ),
    );
  }
}

class _ActionsButtons extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final notifier = ref.read(authProvider.notifier);

    final auth = ref.watch(authProvider);

    bool isGoogleSignInAvailable() {
      return auth.provider == AuthProvider.google;
    }

    bool isAppleSignInAvailable() {
      return auth.provider == AuthProvider.apple;
    }

    return Column(
      children: [
        if (isGoogleSignInAvailable() || auth.user == null)
          CustomFilledButton(
            margin: const EdgeInsets.only(top: defaultPadding),
            onPressed: isGoogleSignInAvailable()
                ? notifier.logout
                : notifier.onSignInWithGoogle,
            textStyle: style.bodyLarge,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white12),
            child: Row(
              children: [
                SvgPicture.asset('assets/svg/ic_google.svg', width: 28),
                const Gap(8),
                isGoogleSignInAvailable()
                    ? Text('${auth.user?.email}')
                    : const Text('Sign in with Google'),
                const Spacer(),
                isGoogleSignInAvailable()
                    ? const Icon(BoxIcons.bx_x)
                    : Container()
              ],
            ),
          ),
        if (isAppleSignInAvailable() || auth.user == null)
          CustomFilledButton(
            margin: const EdgeInsets.only(top: defaultPadding),
            onPressed: isAppleSignInAvailable()
                ? notifier.logout
                : notifier.onSignInWithApple,
            textStyle: style.bodyLarge,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white12),
            child: Row(
              children: [
                const Icon(BoxIcons.bxl_apple, size: 28),
                const Gap(8),
                isAppleSignInAvailable()
                    ? Text('${auth.user?.email}')
                    : const Text('Sign in with Apple'),
                const Spacer(),
                isAppleSignInAvailable()
                    ? const Icon(BoxIcons.bx_x)
                    : Container()
              ],
            ),
          ),
        CustomFilledButton(
          margin: const EdgeInsets.only(top: defaultPadding),
          onPressed: ref.read(introProvider.notifier).onNextPage,
          textStyle: style.bodyLarge,
          child: (auth.user != null)
              ? const Text('Continue')
              : const Text('Skip for now'),
        ),
      ],
    );
  }
}
