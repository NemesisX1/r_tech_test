import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
part 'event.mapper.dart';

// ignore: must_be_immutable
class Event extends Equatable {
  Event({
    required this.id,
    required this.title,
    required this.endDate,
    required this.startDate,
    required this.ticketType,
    required this.status,
    required this.type,
    required this.description,
    this.location,
    this.pricing = 0.0,
    this.pictureUrl,
    this.rating,
    this.attendeeIDs,
  }) {
    attendeeIDs = attendeeIDs ?? [];
  }

  final String title;
  final String? location;
  final DateTime startDate;
  final DateTime endDate;
  final double? rating;
  final double pricing;
  final EventStatus status;
  final EventTicketType ticketType;
  final EventLocationType type;
  final String? pictureUrl;
  final String description;
  final String id;
  List<String>? attendeeIDs;

  @override
  List<Object?> get props => [
        id,
      ];
}

@MappableEnum()
enum EventStatus {
  paid,
  completed,
  canceled,
  upcoming,
}

@MappableEnum()
enum EventTicketType {
  free,
  paid,
}

@MappableEnum()
enum EventLocationType {
  offline,
  online,
}
