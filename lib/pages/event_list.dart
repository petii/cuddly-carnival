import 'package:flutter/material.dart';
import 'package:i18n_extension/default.i18n.dart';

import '../widgets/event_entry.dart';

class EventList extends StatefulWidget {
  EventList({Key? key}) : super(key: key);

  final String title = 'Your Events'.i18n;

  @override
  State<StatefulWidget> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => {},
              tooltip: 'Search'.i18n,
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () => {},
              tooltip: 'Discover more events on Facebook'.i18n,
              icon: const Icon(Icons.add)),
        ],
      ),
      body: ListView(
        children: const <Widget>[
          EventEntry(),
        ],
      ),
    );
  }
}
