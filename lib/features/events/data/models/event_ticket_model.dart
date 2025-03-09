import 'package:dart_mappable/dart_mappable.dart';

part 'event_ticket_model.mapper.dart';

@MappableClass()
class EventTicketModel with EventTicketModelMappable {
  EventTicketModel({
    required this.eventId,
    required this.userId,
    required this.ticketCount,
    required this.price,
    DateTime? createdAt,
  }) : _createdAt = createdAt;

  final String eventId;
  final String userId;
  final int ticketCount;
  final double price;
  final DateTime? _createdAt;

  DateTime get createdAt => _createdAt ?? DateTime.now();
}
