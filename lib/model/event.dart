import 'dart:math';

class CoverModel {
  final Point? offset;
  final Uri source;
  final String id;

  const CoverModel(this.id, this.source, this.offset);

  CoverModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        source = Uri.parse(json['source']),
        offset = null;
  // Point(num.parse(json['offset_x']), num.parse(json['offset_y']));
}

class EventModel {
  final String id;
  final String? name;
  final CoverModel? cover;
  final DateTime? startTime;
  final DateTime? endTime;

  const EventModel(
      this.id, this.name, this.cover, this.startTime, this.endTime);

  EventModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        cover =
            json['cover'] != null ? CoverModel.fromJson(json['cover']) : null,
        startTime = json['start_time'] != null
            ? DateTime.parse(json['start_time'])
            : null,
        endTime =
            json['end_time'] != null ? DateTime.parse(json['end_time']) : null;

  Map<String, dynamic> toJson() => {};
}
