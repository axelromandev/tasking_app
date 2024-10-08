import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskNotesModal extends StatefulWidget {
  const TaskNotesModal({
    this.value,
    super.key,
  });

  final String? value;

  @override
  State<TaskNotesModal> createState() => _TaskNotesModalState();
}

class _TaskNotesModalState extends State<TaskNotesModal> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              controller: controller,
              maxLines: null,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                LengthLimitingTextInputFormatter(255),
              ],
              decoration: InputDecoration(
                filled: false,
                hintText: 'Notas',
                suffixIcon: (controller.text.isNotEmpty &&
                        (widget.value?.isNotEmpty ?? false))
                    ? IconButton(
                        onPressed: () {
                          controller.clear();
                          Navigator.pop(context, '');
                        },
                        color: Colors.redAccent,
                        icon: const Icon(IconsaxOutline.trash),
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onFieldSubmitted: (value) {
                Navigator.pop(context, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
