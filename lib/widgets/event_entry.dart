import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';

String eventDateFormatting({DateTime? startTime, DateTime? endTime}) {
  final fullDateTime = DateFormat('y MMMM d H:mm');
  final shortDateTimeWithYear = DateFormat('y MMM d h:mm');
  final shortDateTime = DateFormat('MMM d h:mm');
  final dayAndTime = DateFormat('d H:mm');
  final timeOfDay = DateFormat('H:mm');
  if (startTime == null) {
    return 'TBD';
  }
  if (endTime == null) {
    return DateFormat('y MMMM d H:mm').format(startTime);
  }
  if (startTime.year != endTime.year) {
    return '${shortDateTimeWithYear.format(startTime)} - ${shortDateTimeWithYear.format(endTime)}';
  }
  if (startTime.month != endTime.month) {
    return '${shortDateTimeWithYear.format(startTime)} - ${shortDateTime.format(endTime)}';
  }
  if (startTime.day != endTime.day) {
    return '${shortDateTimeWithYear.format(startTime)} - ${shortDateTime.format(endTime)}';
  }
  return '${shortDateTimeWithYear.format(startTime)} - ${timeOfDay.format(endTime)}';
}

class EventEntry extends StatelessWidget {
  const EventEntry(this.event, {Key? key}) : super(key: key);

  void onAddToCalendar() {
    log('${event.id} - add to calendar');
  }

  void onViewDetails() {
    log('${event.id} - view details');
  }

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 6),
          isThreeLine: false,
          leading: event.cover != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    event.cover!.source.toString(),
                  ),
                )
              : const Icon(Icons.broken_image_rounded),
          title: Text(
            event.name ?? 'TBD',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            eventDateFormatting(
                startTime: event.startTime, endTime: event.endTime),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: IconButton(
            // icon: Icon(Icons.event_available),
            icon: Icon(Icons.event_note),
            onPressed: onAddToCalendar,
          ),
        ),
        onTap: onViewDetails,
      ),
    );
  }
}
