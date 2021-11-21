import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:i18n_extension/default.i18n.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook - Discover Events'.i18n),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => {},
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.list),
          )
        ],
      ),
      drawer: Drawer(
        child: Text('drawer'),
      ),
      body: WebView(
        initialUrl: 'https://facebook.com/events/discovery',
        onPageStarted: (String url) => {log(url)},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.keyboard_return),
      ),
    );
  }
}
