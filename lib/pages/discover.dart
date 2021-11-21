import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:i18n_extension/default.i18n.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const WebView(
        initialUrl: 'https://facebook.com/events/discovery',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pop(context)},
        child: const Icon(Icons.done),
      ),
    );
  }
}
