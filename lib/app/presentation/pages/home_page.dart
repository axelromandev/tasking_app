import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static String routePath = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: HomePage Implement build method.
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/svg/logo_icon.svg', height: 24),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text('Your Tasks',
                        style: style.headlineLarge?.copyWith(
                          color: Colors.white,
                        )),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(HeroIcons.plus),
                      label: Text('Add',
                          style: style.titleMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const CardTask(
                id: '1',
                text: 'Finish Marketing Presentation',
              ),
              const CardTask(
                id: '2',
                text: 'Call Grandma',
              ),
              const CardTask(
                id: '3',
                text: 'Grocery Shopping',
              ),
              const CardTask(
                id: '4',
                text: 'Study for Math Test',
              ),
              const CardTask(
                id: '5',
                text: 'Gym Workout',
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Completed Tasks'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
