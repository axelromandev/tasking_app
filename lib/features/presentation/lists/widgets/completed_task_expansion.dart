import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class CompletedTaskExpansion extends StatefulWidget {
  const CompletedTaskExpansion({
    required this.length,
    this.margin,
    required this.child,
    super.key,
  });

  final int length;
  final EdgeInsets? margin;
  final Widget child;

  @override
  State<CompletedTaskExpansion> createState() => _CompletedTaskExpansionState();
}

class _CompletedTaskExpansionState extends State<CompletedTaskExpansion> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: widget.margin,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() {
                isExpanded = !isExpanded;
              }),
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isExpanded
                          ? IconsaxOutline.arrow_up_2
                          : IconsaxOutline.arrow_down_1,
                      key: ValueKey<bool>(isExpanded),
                      size: 16,
                    ),
                    const Gap(8),
                    Text(
                      S.features.lists.page.completed(
                        length: widget.length,
                      ),
                      style: style.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Gap(defaultPadding),
        if (isExpanded) widget.child else Container(),
      ],
    );
  }
}
