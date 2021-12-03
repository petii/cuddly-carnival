import 'dart:developer';

import 'package:cuddly_carnival/model/event.dart';
import 'package:cuddly_carnival/model/response.dart';
import 'package:cuddly_carnival/routes.dart';
import 'package:cuddly_carnival/utils/event_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../routes.dart';
import '../widgets/event_entry.dart';

class EventList extends StatefulWidget {
  EventList({required AccessToken accessToken, Key? key})
      : requests = EventRequests(accessToken),
        super(key: key);

  final EventRequests requests;

  static const _firstPage = Pagination(null, null);

  final PagingController<Pagination, EventModel> _pagingController =
      PagingController(firstPageKey: _firstPage);

  Future<void> fetchEvents(Pagination pageKey) async {
    try {
      log('pageKey: ' + pageKey.toJson().toString());
      EventResponseModel response;
      if (pageKey.cursors == null && pageKey.next == null) {
        response = await requests.get(
          fields: [
            'id',
            'start_time',
            'end_time',
            'name',
            'cover',
            'description',
          ],
          limit: 15, // Chosen by a fair dice roll
        );
      } else /*if (pageKey.next != null)*/ {
        response = await requests.getNext(pageKey.next!);
      }
      if (response.data == null) {
        throw Error();
      }
      log('response.paging:' + (response.paging?.toJson().toString() ?? ''));
      var items = response.data!.toList();

      bool lastPage = response.paging?.next == null;
      if (lastPage) {
        _pagingController.appendLastPage(items);
      } else {
        _pagingController.appendPage(items, response.paging!);
      }
    } catch (error) {
      log(error.toString());
      _pagingController.error = error;
    }
  }

  @override
  State<StatefulWidget> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  void initState() {
    super.initState();
    widget._pagingController.addPageRequestListener((pageKey) {
      widget.fetchEvents(pageKey);
    });
  }

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
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.sort),
            // tooltip: 'Sort by'.i18n,
          ),
        ],
      ),
      body: RefreshIndicator(
        child: PagedListView(
          pagingController: widget._pagingController,
          builderDelegate: PagedChildBuilderDelegate<EventModel>(
            itemBuilder: (context, item, index) => EventEntry(item),
          ),
        ),
        onRefresh: () async => widget._pagingController.refresh(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Discover events'.i18n,
        onPressed: () => {Navigator.pushNamed(context, ROUTE.Discover)},
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    widget._pagingController.dispose();
    super.dispose();
  }
}
