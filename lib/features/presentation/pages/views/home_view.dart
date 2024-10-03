import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/i18n/i18n.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: HomeView Implement build method.
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);
    final tasks = ref.read(listsProvider.notifier).getRecentTasks();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              Assets.logo,
              width: 18,
              theme: SvgTheme(currentColor: colorPrimary),
            ),
            const Gap(12),
            Text(
              S.pages.home.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Gap(8),
            Text(
              'beta',
              style: style.bodyMedium?.copyWith(color: colorPrimary),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Yuhuu, ¡tu trabajo casi está terminado!',
              style: style.titleLarge,
            ),
          ),
          const Gap(defaultPadding),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ListTile(
              title: const Text('Tareas diarias'),
              subtitle: const Text(
                '8 de 10 Completados',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(
                        value: 0.8,
                        strokeWidth: 3,
                        color: Colors.white,
                        backgroundColor: Colors.white12,
                      ),
                    ),
                    Center(
                      child: Text('80%', style: style.labelSmall),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(defaultPadding),
          if (tasks.isNotEmpty)
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: const Text('Recientes'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (_, i) {
                    final task = tasks[i];
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      leading: const Icon(BoxIcons.bx_circle),
                      title: Text(task.title),
                    );
                  },
                ),
              ],
            )
          else
            const Text('Libre por hoy :D'),
        ],
      ),
    );
  }
}
