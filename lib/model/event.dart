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

enum EventFields {
  id,
  name,
  place,
  attending_count,
  interested_count,
  maybe_count,
  declined_count,
  noreply_count,
  cover,
  description,
  start_time,
  end_time,
  timezone,
  discount_code_enabled
}

class EventModel {
  final String id;
  final String? name;
  final CoverModel? cover;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? description;

  const EventModel(this.id, this.name, this.cover, this.startTime, this.endTime,
      this.description);

  EventModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        cover =
            json['cover'] != null ? CoverModel.fromJson(json['cover']) : null,
        startTime = json['start_time'] != null
            ? DateTime.parse(json['start_time'])
            : null,
        endTime =
            json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
        description = json['description'];

  Map<String, dynamic> toJson() => {};
}
