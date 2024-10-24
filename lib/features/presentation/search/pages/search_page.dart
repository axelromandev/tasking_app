import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: SearchView Implement build method.

    // final style = Theme.of(context).textTheme;
    // final colorPrimary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(IconsaxOutline.arrow_left_2),
        ),
        title: TextFormField(
          autofocus: true,
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search',
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            onPressed: (_controller.text.isNotEmpty)
                ? () => setState(() => _controller.clear())
                : null,
            icon: const Icon(Icons.close),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxOutline.more),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(IconsaxOutline.search_normal, size: 36),
            Gap(8),
            Text('SearchView'),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
