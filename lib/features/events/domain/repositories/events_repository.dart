import 'package:repat_event/features/events/domain/entities/event.dart';

abstract class EventsRepository {
  Future<List<Event>> getEvents({
    DateTime? byDate,
    List<EventStatus>? byStatus,
    EventLocationType? byLocationType,
  });

  Future<List<Event>> getUserRegisteredEvents(
    String userId, {
    DateTime? byDate,
    List<EventStatus>? byStatus,
    EventLocationType? byLocationType,
  });

  Future<void> registerUserForEvent({
    required String eventId,
    required String userId,
    required int ticketCount,
  });

  Future<void> cancelUserBookingFromEvent({
    required String eventId,
    required String userId,
    String? reason,
  });
}
