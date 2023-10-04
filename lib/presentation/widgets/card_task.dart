import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CardTask extends StatelessWidget {
  final String id;
  final String text;
  final bool isCheck;

  const CardTask({
    required this.id,
    required this.text,
    this.isCheck = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Dismissible(
      key: Key(id),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minLeadingWidth: 0,
          title: Text(
            text,
            style: style.titleMedium?.copyWith(
              fontWeight: FontWeight.w300,
              color: isCheck ? Colors.grey : Colors.white,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                Iconsax.clock,
                size: 14,
                color: isCheck ? Colors.grey : Colors.white,
              ),
              const SizedBox(width: 4),
              Text('15:00',
                  style: style.bodySmall?.copyWith(
                    color: isCheck ? Colors.grey : Colors.white,
                  )),
              const SizedBox(width: 8),
              Card(
                color: isCheck ? Colors.grey : Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text('Work',
                      style: style.bodySmall?.copyWith(
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
