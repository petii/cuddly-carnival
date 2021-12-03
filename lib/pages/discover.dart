import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int progress = 0;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final middle = LinearProgressIndicator(
      value: progress.toInt() / 100,
      color: Colors.lightBlue,
    );
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: middle,
        leading: const Text(''),
        trailing: const Text(''),
      ),
      body: WebView(
        initialUrl: 'https://facebook.com/events/discovery',
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        gestureNavigationEnabled: true,
        initialMediaPlaybackPolicy:
            AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        debuggingEnabled: true,
        onProgress: (int progress) => setState(() {
          progress = progress;
        }),
        onWebViewCreated: (WebViewController controller) => setState(() {
          controller = controller;
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pop(context)},
        child: const Icon(Icons.done),
      ),
    );
  }
}
