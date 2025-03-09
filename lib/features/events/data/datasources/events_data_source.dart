import 'package:repat_event/features/events/data/models/event_model.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';

// ignore: one_member_abstracts
abstract class EventsDataSource {
  Future<List<EventModel>> fetchEvents({
    DateTime? byDate,
    EventStatus? byStatus,
    EventLocationType? byLocationType,
  });

  Future<List<EventModel>> fetchUserRegisteredEvents(
    String userId, {
    DateTime? byDate,
    EventStatus? byStatus,
    EventLocationType? byLocationType,
  });

  Future<EventModel> addUserToEventAttendees({
    required String eventId,
    required String userId,
    required int ticketCount,
  });

  Future<EventModel> removeUserFromEventAttendees({
    required String eventId,
    required String userId,
    String? reason,
  });
}
