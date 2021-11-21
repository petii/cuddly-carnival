import 'dart:developer';

import 'package:cuddly_carnival/routes.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/default.i18n.dart';

import '../widgets/event_entry.dart';
import '../routes.dart';

class EventList extends StatefulWidget {
  EventList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Events'.i18n),
        actions: [
          IconButton(
              onPressed: () => {},
              tooltip: 'Search'.i18n,
              icon: const Icon(Icons.search)),
        ],
      ),
      body: ListView(
        children: const <Widget>[
          EventEntry(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {Navigator.pushNamed(context, ROUTE.Discover)},
          child: const Icon(Icons.add)),
    );
  }
}
