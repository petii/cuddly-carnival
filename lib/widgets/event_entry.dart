import 'package:flutter/material.dart';

import '../model/event_model.dart';

class EventEntry extends StatelessWidget {
  const EventEntry(this.event, {Key? key}) : super(key: key);

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(event.cover.source.toString()),
      title: Text(
        event.startTime != null ? event.startTime!.toLocal().toString() : 'TBD',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(event.name),
    );
  }
}
