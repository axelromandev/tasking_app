import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskNotesModal extends StatelessWidget {
  const TaskNotesModal({
    this.value,
    super.key,
  });

  final String? value;

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
              initialValue: value,
              maxLines: null,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                LengthLimitingTextInputFormatter(255),
              ],
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Notas',
              ),
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
