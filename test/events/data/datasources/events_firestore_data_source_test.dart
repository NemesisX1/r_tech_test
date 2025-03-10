import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repat_event/features/events/data/datasources/events_firestore_data_source_impl.dart';
import 'package:repat_event/features/events/data/models/event_model.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late EventsFirestoreDataSource dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = EventsFirestoreDataSource(fakeFirestore);
  });

  final testEventData = {
    'id': 'event1',
    'title': 'Test Event',
    'description': 'Test Description',
    'startDate': DateTime(2023, 5, 15, 10).toIso8601String(),
    'endDate': DateTime(2023, 5, 15, 12).toIso8601String(),
    'location': 'Test Location',
    'type': EventLocationType.online.name,
    'status': EventStatus.upcoming.name,
    'ticketType': EventTicketType.free.name,
    'attendeeIDs': ['user1', 'user2'],
    'pictureUrl': 'https://example.com/image.jpg',
    'pricing': 0.0,
    'rating': 4.5,
  };

  final testEvent2Data = {
    'id': 'event2',
    'title': 'Another Event',
    'description': 'Another Description',
    'startDate': DateTime(2023, 5, 16, 10).toIso8601String(),
    'endDate': DateTime(2023, 5, 16, 12).toIso8601String(),
    'location': 'Another Location',
    'type': EventLocationType.offline.name,
    'status': EventStatus.completed.name,
    'ticketType': EventTicketType.paid.name,
    'attendeeIDs': ['user3'],
    'pictureUrl': 'https://example.com/image2.jpg',
    'pricing': 10.0,
    'rating': 4.0,
  };

  group('fetchEvents', () {
    test('should return list of events when no filters are applied', () async {
      await fakeFirestore.collection('events').add(testEventData);

      final result = await dataSource.fetchEvents();

      expect(result, isA<List<EventModel>>());
      expect(result.length, 1);
      expect(result.first.id, 'event1');
      expect(result.first.title, 'Test Event');
    });

    test('should filter events by date', () async {
      await fakeFirestore.collection('events').add(testEventData);
      await fakeFirestore.collection('events').add(testEvent2Data);

      final result = await dataSource.fetchEvents(
        byDate: DateTime(2023, 5, 15),
      );

      expect(result.length, 1);
      expect(result.first.id, 'event1');
    });

    test('should filter events by status', () async {
      await fakeFirestore.collection('events').add(testEventData);
      await fakeFirestore.collection('events').add(testEvent2Data);

      final result = await dataSource.fetchEvents(
        byStatus: [EventStatus.upcoming],
      );

      expect(result.length, 1);
      expect(result.first.id, 'event1');
      expect(result.first.status, EventStatus.upcoming);
    });

    test('should filter events by location type', () async {
      await fakeFirestore.collection('events').add(testEventData);
      await fakeFirestore.collection('events').add(testEvent2Data);

      final result = await dataSource.fetchEvents(
        byLocationType: EventLocationType.online,
      );

      expect(result.length, 1);
      expect(result.first.id, 'event1');
      expect(result.first.type, EventLocationType.online);
    });

    test('should apply multiple filters simultaneously', () async {
      await fakeFirestore.collection('events').add(testEventData);
      await fakeFirestore.collection('events').add(testEvent2Data);

      final testEvent3Data = Map<String, dynamic>.from(testEventData);
      testEvent3Data['id'] = 'event3';
      testEvent3Data['status'] = EventStatus.completed.name;
      await fakeFirestore.collection('events').add(testEvent3Data);

      final result = await dataSource.fetchEvents(
        byDate: DateTime(2023, 5, 15),
        byStatus: [EventStatus.upcoming],
      );

      expect(result.length, 1);
      expect(result.first.id, 'event1');
    });
  });

  group('addUserToEventAttendees', () {
    test('should add user to event attendees and return updated event model',
        () async {
      const userId = 'newUser';
      const eventId = 'event1';
      const ticketCount = 1;

      await fakeFirestore.collection('events').add(testEventData);

      final result = await dataSource.addUserToEventAttendees(
        eventId: eventId,
        userId: userId,
        ticketCount: ticketCount,
      );

      expect(result, isA<EventModel>());
      expect(result.attendeeIDs, contains(userId));

      final updatedDoc = await fakeFirestore
          .collection('events')
          .where('id', isEqualTo: eventId)
          .get();
      final updatedData = updatedDoc.docs.first.data();
      expect(updatedData['attendeeIDs'], contains(userId));
    });
  });

  group('fetchUserRegisteredEvents', () {
    test('should return list of events registered by user', () async {
      const userId = 'user1';

      await fakeFirestore
          .collection('events')
          .add(testEventData); // Contains user1
      await fakeFirestore
          .collection('events')
          .add(testEvent2Data); // Does not contain user1

      final result = await dataSource.fetchUserRegisteredEvents(userId);

      expect(result, isA<List<EventModel>>());
      expect(result.length, 1);
      expect(result.first.id, 'event1');
    });

    test('should filter user registered events by date', () async {
      const userId = 'user1';

      await fakeFirestore.collection('events').add(testEventData);

      final testEvent3Data = Map<String, dynamic>.from(testEventData);
      testEvent3Data['id'] = 'event3';
      testEvent3Data['startDate'] = DateTime(2023, 5, 16, 10).toIso8601String();
      testEvent3Data['endDate'] = DateTime(2023, 5, 16, 12).toIso8601String();
      await fakeFirestore.collection('events').add(testEvent3Data);

      final result = await dataSource.fetchUserRegisteredEvents(
        userId,
        byDate: DateTime(2023, 5, 15),
      );

      expect(result.length, 1);
      expect(result.first.id, 'event1');
    });

    test('should filter user registered events by status', () async {
      const userId = 'user1';

      await fakeFirestore.collection('events').add(testEventData);

      final testEvent3Data = Map<String, dynamic>.from(testEventData);
      testEvent3Data['id'] = 'event3';
      testEvent3Data['status'] = EventStatus.completed.name;
      await fakeFirestore.collection('events').add(testEvent3Data);

      final result = await dataSource.fetchUserRegisteredEvents(
        userId,
        byStatus: [EventStatus.upcoming],
      );

      expect(result.length, 1);
      expect(result.first.id, 'event1');
    });

    test('should filter user registered events by location type', () async {
      const userId = 'user1';

      await fakeFirestore.collection('events').add(testEventData);

      final testEvent3Data = Map<String, dynamic>.from(testEventData);
      testEvent3Data['id'] = 'event3';
      testEvent3Data['type'] = EventLocationType.offline.name;
      await fakeFirestore.collection('events').add(testEvent3Data);

      final result = await dataSource.fetchUserRegisteredEvents(
        userId,
        byLocationType: EventLocationType.online,
      );

      expect(result.length, 1);
      expect(result.first.id, 'event1');
    });

    test('should return empty list when user has no registered events',
        () async {
      const userId = 'nonExistentUser';

      await fakeFirestore.collection('events').add(testEventData);

      final result = await dataSource.fetchUserRegisteredEvents(userId);

      expect(result, isEmpty);
    });
  });
}
