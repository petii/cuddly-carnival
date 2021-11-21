import 'dart:developer';

import 'package:cuddly_carnival/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:http/http.dart' as http;

import '../widgets/event_entry.dart';
import '../routes.dart';

// const String eventsPath = 'http://echo.jsontest.com/key/';
const String eventsPath =
    'https://graph.facebook.com/v11.0/me/events?fields=id,name&access_token=';
// const String eventsPath = 'http://headers.jsontest.com/';

class EventList extends StatefulWidget {
  const EventList({required this.accessToken, Key? key}) : super(key: key);

  Future<dynamic> getEvents() async {
    http.Response response =
        await http.get(Uri.parse(eventsPath + accessToken.token));
    log(response.statusCode.toString());
    return response.body;
  }

  final AccessToken accessToken;

  @override
  State<StatefulWidget> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    log(widget.accessToken.token);
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
      body: FutureBuilder(
        future: widget.getEvents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          log(snapshot.toString());
          return ListView(
            children: [
              Text(snapshot.connectionState.toString()),
              Text(snapshot.toString()),
              Text(snapshot.data.toString()),
            ],
          );
        },
      ),
      //  ListView(
      //   children: const <Widget>[
      //     EventEntry(),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, ROUTE.Discover)},
        child: const Icon(Icons.add),
      ),
    );
  }
}
