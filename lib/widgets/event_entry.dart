import 'dart:developer';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';

String eventDateFormatting({DateTime? startTime, DateTime? endTime}) {
  final fullDateTime = DateFormat('y MMMM d H:mm');
  final shortDateTimeWithYear = DateFormat('y MMM d h:mm');
  final shortDateTime = DateFormat('MMM d h:mm');
  final timeOfDay = DateFormat('H:mm');
  if (startTime == null) {
    return 'TBD';
  }
  if (endTime == null) {
    return fullDateTime.format(startTime);
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
  return '${fullDateTime.format(startTime)} - ${timeOfDay.format(endTime)}';
}

class EventEntry extends StatefulWidget {
  EventEntry(this.event, {Key? key})
      : _cover = Image.network(event.cover!.source.toString()),
        super(key: key);

  final EventModel event;

  final Image _cover;

  @override
  State<EventEntry> createState() => _EventEntryState();
}

class _EventEntryState extends State<EventEntry> {
  bool _expanded = false;

  void onAddToCalendar() {
    log('${widget.event.id} - add to calendar');
    Add2Calendar.addEvent2Cal(
      Event(
        title: widget.event.name ?? 'TBD',
        startDate: widget.event.startTime!,
        endDate: widget.event.endTime ??
            widget.event.startTime!.add(const Duration(hours: 1)),
      ),
    );
  }

  void onToggleDetails() {
    log('${widget.event.id} - view details');
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: _expanded
            ? Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: widget._cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.event.name ?? 'TBD',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      eventDateFormatting(
                          startTime: widget.event.startTime,
                          endTime: widget.event.endTime),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.event.description ?? ''),
                  ),
                  // FutureBuilder(builder: ) // for description et al
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: onAddToCalendar,
                        child: Text('Add to calendar'.i18n),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('View event on Facebook'.i18n),
                      ),
                    ],
                  )
                ],
              )
            : ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                isThreeLine: false,
                leading: widget.event.cover != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget._cover,
                      )
                    : const Icon(Icons.broken_image_rounded),
                title: Text(
                  widget.event.name ?? 'TBD',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  eventDateFormatting(
                      startTime: widget.event.startTime,
                      endTime: widget.event.endTime),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: IconButton(
                  // icon: Icon(Icons.event_available),
                  icon: const Icon(Icons.event),
                  onPressed: onAddToCalendar,
                ),
              ),
        onTap: onToggleDetails,
      ),
    );
  }
}
