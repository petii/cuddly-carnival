import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/event_entry.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  final String title = 'Your Events';

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
          IconButton(onPressed: () =>{}, tooltip: 'Search your events', icon: const Icon(Icons.search)),
          IconButton(onPressed: () =>{}, tooltip: 'Discover more events', icon: const Icon(Icons.add)),
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
