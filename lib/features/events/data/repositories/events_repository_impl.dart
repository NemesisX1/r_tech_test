import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:repat_event/core/errors/exceptions.dart';
import 'package:repat_event/features/events/data/datasources/events_data_source.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/domain/repositories/events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  const EventsRepositoryImpl(
    this.dataSource,
  );

  final EventsDataSource dataSource;

  @override
  Future<List<Event>> getEvents({
    DateTime? byDate,
    EventStatus? byStatus,
    EventLocationType? byLocationType,
  }) async {
    try {
      final eventModels = await dataSource.fetchEvents(
        byDate: byDate,
        byStatus: byStatus,
        byLocationType: byLocationType,
      );

      return eventModels.map((model) => model as Event).toList();
    } catch (e, trace) {
      if (kDebugMode) {
        log('$e');
        log(trace.toString());
      }
      throw EventsException();
    }
  }

  @override
  Future<List<Event>> getUserRegisteredEvents(
    String userId, {
    DateTime? byDate,
    EventStatus? byStatus,
    EventLocationType? byLocationType,
  }) async {
    try {
      final eventModels = await dataSource.fetchUserRegisteredEvents(
        userId,
        byDate: byDate,
        byStatus: byStatus,
        byLocationType: byLocationType,
      );

      return eventModels.map((model) => model as Event).toList();
    } catch (e, trace) {
      if (kDebugMode) {
        log('$e');
        log(trace.toString());
      }
      throw EventsException();
    }
  }

  @override
  Future<void> registerUserForEvent({
    required String eventId,
    required String userId,
    required int ticketCount,
  }) async {
    try {
      await dataSource.addUserToEventAttendees(
        eventId: eventId,
        userId: userId,
        ticketCount: ticketCount,
      );
    } catch (e, trace) {
      if (kDebugMode) {
        log('$e');
        log(trace.toString());
      }
      throw EventsException();
    }
  }

  @override
  Future<void> cancelUserBookingFromEvent({
    required String eventId,
    required String userId,
    String? reason,
  }) async {
    try {
      await dataSource.removeUserFromEventAttendees(
        eventId: eventId,
        userId: userId,
        reason: reason,
      );
    } catch (e, trace) {
      if (kDebugMode) {
        log('$e');
        log(trace.toString());
      }
      throw EventsException();
    }
  }
}
