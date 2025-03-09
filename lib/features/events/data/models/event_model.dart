import 'package:dart_mappable/dart_mappable.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';

part 'event_model.mapper.dart';

@MappableClass()
// ignore: must_be_immutable
class EventModel extends Event with EventModelMappable {
  EventModel({
    required super.id,
    required super.title,
    required super.endDate,
    required super.startDate,
    required super.ticketType,
    required super.status,
    required super.type,
    required super.description,
    required super.rating,
    required super.pictureUrl,
    required super.pricing,
    required super.location,
    super.attendeeIDs,
    DateTime? createdAt,
  }) : _createdAt = createdAt;

  factory EventModel.fromEntity(Event event) {
    return EventModel(
      id: event.id,
      title: event.title,
      location: event.location,
      endDate: event.endDate,
      startDate: event.startDate,
      rating: event.rating,
      pictureUrl: event.pictureUrl,
      pricing: event.pricing,
      ticketType: event.ticketType,
      status: event.status,
      type: event.type,
      description: event.description,
    );
  }

  DateTime? _createdAt;

  DateTime get createdAt => _createdAt ?? DateTime.now();

  set createdAt(DateTime? value) {
    _createdAt = value;
  }
}
