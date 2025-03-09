import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repat_event/features/events/data/datasources/events_data_source.dart';
import 'package:repat_event/features/events/data/models/event_model.dart';
import 'package:repat_event/features/events/data/models/event_ticket_model.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';

class EventsFirestoreDataSource implements EventsDataSource {
  EventsFirestoreDataSource(
    this.store,
  );

  final FirebaseFirestore store;

  @override
  Future<List<EventModel>> fetchEvents({
    DateTime? byDate,
    EventStatus? byStatus,
    EventLocationType? byLocationType,
  }) async {
    final events = <EventModel>[];

    final storeEvents = await store.collection('events').get();

    for (final event in storeEvents.docs) {
      final eventModel = EventModelMapper.fromMap(event.data());

      if (byDate != null) {
        final eventDate = eventModel.startDate;
        if (eventDate.year != byDate.year ||
            eventDate.month != byDate.month ||
            eventDate.day != byDate.day) {
          continue;
        }
      }

      if (byStatus != null && eventModel.status != byStatus) {
        continue;
      }

      if (byLocationType != null && eventModel.type != byLocationType) {
        continue;
      }

      events.add(eventModel);
    }

    return events;
  }

  @override
  Future<EventModel> addUserToEventAttendees({
    required String eventId,
    required String userId,
    required int ticketCount,
  }) async {
    final event =
        (await store.collection('events').where('id', isEqualTo: eventId).get())
            .docs
            .first;

    log(event.id);
    final eventData = event.data();

    final eventModel = EventModelMapper.fromMap(eventData);

    if (!eventModel.attendeeIDs!.contains(userId)) {
      eventModel.attendeeIDs?.add(userId);
    }

    await store.collection('events').doc(event.id).update({
      'attendeeIDs': eventModel.attendeeIDs,
    });

    await store.collection('user_events').doc(event.id).set(
          (eventModel..attendeeIDs = null).toMap(),
        );

    await store.collection('events_tickets').add(
          EventTicketModel(
            eventId: eventId,
            userId: userId,
            ticketCount: ticketCount,
            price: eventModel.pricing,
            createdAt: DateTime.now(),
          ).toMap(),
        );

    return eventModel;
  }

  @override
  Future<EventModel> removeUserFromEventAttendees({
    required String eventId,
    required String userId,
    String? reason,
  }) async {
    final event =
        (await store.collection('events').where('id', isEqualTo: eventId).get())
            .docs
            .first;

    final eventData = event.data();

    final eventModel = EventModelMapper.fromMap(eventData);

    if (eventModel.attendeeIDs!.contains(userId)) {
      eventModel.attendeeIDs?.remove(userId);
    }

    await store.collection('events').doc(event.id).update({
      'attendeeIDs': eventModel.attendeeIDs,
    });

    await store.collection('user_events').doc(event.id).delete();

    final ticketsQuery = store
        .collection('events_tickets')
        .where(
          'userId',
          isEqualTo: userId,
        )
        .where(
          'eventId',
          isEqualTo: eventId,
        );

    final ticket = await ticketsQuery.get();

    await store.collection('events_tickets').doc(ticket.docs.first.id).delete();

    await store.collection('events_cancelation_reasons').add({
      'reason': reason,
      'userId': userId,
      'eventId': eventId,
      'createdAt': DateTime.now(),
    });

    return eventModel;
  }

  @override
  Future<List<EventModel>> fetchUserRegisteredEvents(
    String userId, {
    DateTime? byDate,
    EventStatus? byStatus,
    EventLocationType? byLocationType,
  }) async {
    final events = <EventModel>[];

    final storeEvents = await store
        .collection('events')
        .where(
          'attendeeIDs',
          arrayContains: userId,
        )
        .get();

    if (storeEvents.docs.isEmpty) return events;

    for (final event in storeEvents.docs) {
      final eventModel = EventModelMapper.fromMap(event.data());

      if (byDate != null) {
        final eventDate = eventModel.startDate;
        if (eventDate.year != byDate.year ||
            eventDate.month != byDate.month ||
            eventDate.day != byDate.day) {
          continue;
        }
      }

      if (byStatus != null && eventModel.status != byStatus) {
        continue;
      }

      if (byLocationType != null && eventModel.type != byLocationType) {
        continue;
      }

      events.add(eventModel);
    }

    return events;
  }
}
