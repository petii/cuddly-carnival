import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';

class EventEntry extends StatelessWidget {
  const EventEntry(this.event, {Key? key}) : super(key: key);

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(event.cover.source.toString()),
      title: Text(
        event.startTime != null
            ? DateFormat('y MMMM d H:mm').format(event.startTime!)
            : 'TBD',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(event.name),
    );
  }
}
