import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class IconPicker extends StatefulWidget {
  const IconPicker({
    required this.onIconChanged,
    this.icon,
    this.padding,
    super.key,
  });

  final Function(IconData) onIconChanged;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  final List<IconData> icons = [
    IconsaxOutline.folder,
    IconsaxOutline.home_2,
    IconsaxOutline.briefcase,
    IconsaxOutline.cloud,
    IconsaxOutline.lock,
    IconsaxOutline.star,
    IconsaxOutline.heart,
    IconsaxOutline.document_download,
    IconsaxOutline.document_upload,
    IconsaxOutline.edit,
    IconsaxOutline.info_circle,
    IconsaxOutline.search_normal,
    IconsaxOutline.setting,
    IconsaxOutline.archive,
    IconsaxOutline.document_1,
    IconsaxOutline.note,
    IconsaxOutline.clipboard_text,
    IconsaxOutline.code,
    IconsaxOutline.trend_up,
    IconsaxOutline.trend_down,
    IconsaxOutline.user,
    IconsaxOutline.shield,
    IconsaxOutline.filter,
    IconsaxOutline.trash,
    IconsaxOutline.notification,
    IconsaxOutline.chart_square,
    IconsaxOutline.refresh,
    IconsaxOutline.flag,
    IconsaxOutline.crown,
  ];

  late IconData selected;

  @override
  void initState() {
    selected = widget.icon ?? icons.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: icons.length,
      padding: widget.padding,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemBuilder: (_, index) {
        final icon = icons[index];
        return GestureDetector(
          onTap: () {
            setState(() => selected = icon);
            widget.onIconChanged(icon);
          },
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: (selected.codePoint == icon.codePoint)
                  ? Colors.amber
                  : Colors.white60,
            ),
          ),
        );
      },
    );
  }
}
