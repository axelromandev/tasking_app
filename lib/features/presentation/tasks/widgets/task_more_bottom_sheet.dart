import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class TaskMoreBottomSheet extends StatelessWidget {
  const TaskMoreBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: TaskOptionsModal Implement onTa

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: ListTile(
                onTap: () {},
                leading: const Icon(IconsaxOutline.shuffle),
                title: const Text('Move to another list'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {},
                leading: const Icon(IconsaxOutline.trash),
                title: const Text('Delete'),
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
