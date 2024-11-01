import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/search/search.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            decoration: const BoxDecoration(
              color: AppColors.background,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(IconsaxOutline.arrow_left_2),
                  ),
                ),
                Expanded(child: _SearchField()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconsaxOutline.more),
                ),
                const Gap(8),
              ],
            ),
          ),
          _TaskBuilder(),
        ],
      ),
    );
  }
}

class _SearchField extends ConsumerStatefulWidget {
  @override
  ConsumerState<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<_SearchField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(searchProvider.notifier);

    return TextFormField(
      autofocus: true,
      autocorrect: false,
      controller: _controller,
      decoration: InputDecoration(
        hintText: S.features.search.title,
        filled: false,
        contentPadding: EdgeInsets.zero,
        suffixIcon: (_controller.text.isNotEmpty)
            ? IconButton(
                onPressed: () {
                  setState(() => _controller.clear());
                  notifier.onChangeSearch('');
                },
                icon: const Icon(Icons.close),
              )
            : null,
      ),
      onChanged: (value) {
        setState(() {});
        notifier.onChangeSearch(value);
      },
    );
  }
}

class _TaskBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(searchProvider);
    final notifier = ref.read(searchProvider.notifier);

    if (provider.isSearching) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorPrimary,
                ),
              ),
              const Gap(8),
              Text(S.features.search.searching, style: style.bodyLarge),
            ],
          ),
        ),
      );
    }

    if (provider.groups.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                IconsaxOutline.search_normal,
                color: colorPrimary,
                size: 32,
              ),
              const Gap(8),
              Text(S.features.search.empty, style: style.bodyLarge),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView(
        children: provider.groups.keys.map((listTitle) {
          final tasks = provider.groups[listTitle]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Text(listTitle, style: style.bodyLarge),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                separatorBuilder: (_, __) => const Gap(6),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: task,
                    onTap: () {
                      ref.read(taskAccessTypeProvider.notifier).setSearch();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TaskPage(task.id),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    onToggleCompleted: () => notifier.toggleCompleted(task),
                    onToggleImportant: () => notifier.toggleImportant(task),
                  );
                },
              ),
              const Gap(defaultPadding),
            ],
          );
        }).toList(),
      ),
    );
  }
}
