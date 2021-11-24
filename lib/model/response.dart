import 'package:cuddly_carnival/model/event.dart';

class Cursors {
  final String? before;
  final String? after;

  const Cursors(this.before, this.after);

  Cursors.fromJson(Map<String, dynamic> json)
      : before = json['before'],
        after = json['after'];
}

class Pagination {
  final Cursors? cursors;
  final Uri? next;

  const Pagination(this.cursors, this.next);

  Pagination.fromJson(Map<String, dynamic> json)
      : cursors =
            json['cursors'] != null ? Cursors.fromJson(json['cursors']) : null,
        next = Uri.tryParse(json['next'] ?? '');
}

class EventResponseModel {
  final Iterable<EventModel>? data;
  final Pagination? paging;

  const EventResponseModel(this.data, this.paging);

  EventResponseModel.fromJson(Map<String, dynamic> json)
      : data = json['data'] != null
            ? (json['data'] as List<dynamic>)
                .map((dataElement) => EventModel.fromJson(dataElement))
            : null,
        paging =
            json['paging'] != null ? Pagination.fromJson(json['paging']) : null;
}
