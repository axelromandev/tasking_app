import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../config/config.dart';

class WebViewPage extends ConsumerStatefulWidget {
  const WebViewPage({required this.url, this.title, super.key});

  final String? title;
  final Uri url;

  @override
  ConsumerState<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends ConsumerState<WebViewPage> {
  late WebViewController controller;

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() {
    controller = WebViewController()
      ..setBackgroundColor(AppColors.background)
      ..loadRequest(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Icon(
                BoxIcons.bx_chevron_left,
                size: 30.0,
                color: ref.watch(colorThemeProvider),
              ),
            ),
            const Gap(16.0),
            Text(
              widget.title ?? widget.url.host,
              style: style.bodyLarge,
            ),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
