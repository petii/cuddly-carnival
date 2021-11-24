import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';

class EventEntry extends StatelessWidget {
  const EventEntry(this.event, {Key? key}) : super(key: key);

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: event.cover != null
          ? Image.network(event.cover!.source.toString())
          : Icon(Icons.broken_image_rounded),
      title: Text(
        event.startTime != null
            ? DateFormat('y MMMM d H:mm').format(event.startTime!)
            : 'TBD',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(event.name ?? 'TBD'),
    );
  }
}
