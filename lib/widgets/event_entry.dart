import 'dart:developer';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
          description: widget.event.description ?? '',
          location: widget.event.place?.name ?? ''),
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
            ? _ExpandedCard(
                event: widget.event,
                onAddToCalendar: onAddToCalendar,
                cover: widget._cover,
              )
            : _TileCard(
                event: widget.event,
                onAddToCalendar: onAddToCalendar,
                cover: widget._cover,
              ),
        onTap: onToggleDetails,
      ),
    );
  }
}

class _EventData {
  const _EventData(
      {required this.event, required this.onAddToCalendar, this.cover});

  final EventModel event;
  final Image? cover;
  final void Function() onAddToCalendar;
}

class _TileCard extends StatelessWidget {
  _TileCard(
      {required EventModel event,
      required Function() onAddToCalendar,
      Image? cover,
      Key? key})
      : data = _EventData(
            event: event, onAddToCalendar: onAddToCalendar, cover: cover),
        super(key: key);

  const _TileCard.fromData({required this.data, Key? key}) : super(key: key);

  final _EventData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      isThreeLine: false,
      leading: data.event.cover != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: data.cover,
            )
          : const Icon(Icons.broken_image_rounded),
      title: Text(
        data.event.name ?? 'TBD',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        eventDateFormatting(
            startTime: data.event.startTime, endTime: data.event.endTime),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      trailing: IconButton(
        // icon: Icon(Icons.event_available),
        icon: const Icon(Icons.event),
        onPressed: data.onAddToCalendar,
      ),
    );
  }
}

class _ExpandedCard extends StatelessWidget {
  _ExpandedCard(
      {required EventModel event,
      required Function() onAddToCalendar,
      Image? cover,
      Key? key})
      : data = _EventData(
            event: event, onAddToCalendar: onAddToCalendar, cover: cover),
        super(key: key);

  const _ExpandedCard.fromData({required this.data, Key? key})
      : super(key: key);

  final _EventData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: data.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.event.name ?? 'TBD',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            eventDateFormatting(
                startTime: data.event.startTime, endTime: data.event.endTime),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpandableText(
            data.event.description ?? '',
            expandText: 'show more'.i18n,
            collapseText: 'show less'.i18n,
            maxLines: 6,
          ),
        ),
        // FutureBuilder(builder: ) // for description et al
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: data.onAddToCalendar,
              child: Text('Add to calendar'.i18n),
            ),
            TextButton(
              onPressed: () async =>
                  await launch('https://facebook.com/${data.event.id}'),
              child: Text('View event on Facebook'.i18n),
            ),
          ],
        )
      ],
    );
  }
}
