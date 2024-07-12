import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../config/config.dart';
import '../widgets/app_bar_page.dart';

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
    return Scaffold(
      appBar: AppBarPage(title: widget.title ?? widget.url.host),
      body: WebViewWidget(controller: controller),
    );
  }
}
