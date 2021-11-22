import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:i18n_extension/default.i18n.dart';

class DiscoverPage extends StatefulWidget {
  int progress = 0;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: LinearProgressIndicator(
          value: widget.progress / 100,
          color: Colors.lightBlue,
        ),
        leading: Text(''),
        trailing: Text(''),
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
          widget.progress = progress;
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pop(context)},
        child: const Icon(Icons.done),
      ),
    );
  }
}
