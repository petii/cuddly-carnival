import 'dart:developer';

import 'package:cuddly_carnival/model/response.dart';
import 'package:cuddly_carnival/routes.dart';
import 'package:cuddly_carnival/utils/event_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:i18n_extension/default.i18n.dart';

import '../routes.dart';
import '../widgets/event_entry.dart';

const String eventsPath =
    'https://graph.facebook.com/v11.0/me/events?fields=id,name,cover,start_time,end_time&access_token=';

class EventList extends StatefulWidget {
  EventList({required AccessToken accessToken, Key? key})
      : requests = EventRequests(accessToken),
        super(key: key);

  // Future<Map<String, dynamic>> getEvents() async {
  Future<EventResponseModel> getEvents() async {
    return await requests.get();
  }

  final EventRequests requests;

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
            icon: const Icon(Icons.search),
          ),
          // figure out down swipe refresh instead
          // IconButton(
          //   onPressed: () => {},
          //   icon: const Icon(Icons.refresh),
          // ),
        ],
      ),
      body: FutureBuilder(
        future: widget.requests
            .get(fields: ['id', 'start_time', 'end_time', 'name', 'cover']),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final EventResponseModel response;
          if (snapshot.hasData) {
            response = snapshot.data;
          } else {
            return Center(child: Text('loading'));
          }
          // log(response.data.toString());
          // log(response.paging.toString());
          return RefreshIndicator(
            child: ListView(
              children: response.data!
                  .map(
                    (data) => EventEntry(data),
                  )
                  .toList(),
            ),
            onRefresh: () async {
              log('on refresh');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, ROUTE.Discover)},
        child: const Icon(Icons.add),
      ),
    );
  }
}
