import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repat_event/core/errors/exceptions.dart';
import 'package:repat_event/features/events/data/datasources/events_data_source.dart';
import 'package:repat_event/features/events/data/models/event_model.dart';
import 'package:repat_event/features/events/data/repositories/events_repository_impl.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';

class MockEventsDataSource extends Mock implements EventsDataSource {}

void main() {
  late EventsRepositoryImpl repository;
  late MockEventsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockEventsDataSource();
    repository = EventsRepositoryImpl(mockDataSource);
  });

  final testDate = DateTime(2023, 5, 15);

  final testEventModel = EventModel(
    id: 'event1',
    title: 'Test Event',
    description: 'Test Description',
    startDate: DateTime(2023, 5, 15, 10),
    endDate: DateTime(2023, 5, 15, 12),
    location: 'Test Location',
    type: EventLocationType.online,
    status: EventStatus.upcoming,
    ticketType: EventTicketType.free,
    pictureUrl: 'https://example.com/image.jpg',
    pricing: 0,
    rating: 4.5,
  );

  final testEventModel2 = EventModel(
    id: 'event2',
    title: 'Another Event',
    description: 'Another Description',
    startDate: DateTime(2023, 5, 16, 10),
    endDate: DateTime(2023, 5, 16, 12),
    location: 'Another Location',
    type: EventLocationType.offline,
    status: EventStatus.completed,
    ticketType: EventTicketType.paid,
    pictureUrl: 'https://example.com/image2.jpg',
    pricing: 10,
    rating: 4,
  );

  final testEventModels = [testEventModel, testEventModel2];

  group('getEvents', () {
    test('should return list of events when data source call is successful',
        () async {
      // Arrange
      when(
        () => mockDataSource.fetchEvents(
          byDate: any(named: 'byDate'),
          byStatus: any(named: 'byStatus'),
          byLocationType: any(named: 'byLocationType'),
        ),
      ).thenAnswer(
        (_) async => testEventModels,
      );

      // Act
      final result = await repository.getEvents();

      // Assert
      expect(result, isA<List<Event>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('event1'));
      expect(result[1].id, equals('event2'));
      verify(() => mockDataSource.fetchEvents()).called(1);
    });

    test('should pass filters to data source when provided', () async {
      // Arrange
      when(
        () => mockDataSource.fetchEvents(
          byDate: any(named: 'byDate'),
          byStatus: any(named: 'byStatus'),
          byLocationType: any(named: 'byLocationType'),
        ),
      ).thenAnswer((_) async => [testEventModel]);

      // Act
      await repository.getEvents(
        byDate: testDate,
        byStatus: [EventStatus.upcoming],
        byLocationType: EventLocationType.online,
      );

      // Assert
      verify(
        () => mockDataSource.fetchEvents(
          byDate: testDate,
          byStatus: [EventStatus.upcoming],
          byLocationType: EventLocationType.online,
        ),
      ).called(1);
    });

    test('should throw EventsException when data source throws an exception',
        () async {
      // Arrange
      when(
        () => mockDataSource.fetchEvents(
          byDate: any(named: 'byDate'),
          byStatus: any(named: 'byStatus'),
          byLocationType: any(named: 'byLocationType'),
        ),
      ).thenThrow(Exception('Test error'));

      // Act & Assert
      expect(
        () => repository.getEvents(),
        throwsA(isA<EventsException>()),
      );
    });
  });

  group('getUserRegisteredEvents', () {
    const testUserId = 'user1';

    test(
        '''should return list of user registered events when data source call is successful''',
        () async {
      // Arrange
      when(
        () => mockDataSource.fetchUserRegisteredEvents(
          any(),
          byDate: any(named: 'byDate'),
          byStatus: any(named: 'byStatus'),
          byLocationType: any(named: 'byLocationType'),
        ),
      ).thenAnswer((_) async => testEventModels);

      // Act
      final result = await repository.getUserRegisteredEvents(testUserId);

      // Assert
      expect(result, isA<List<Event>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('event1'));
      expect(result[1].id, equals('event2'));
      verify(
        () => mockDataSource.fetchUserRegisteredEvents(
          testUserId,
        ),
      ).called(1);
    });

    test('should pass filters to data source when provided', () async {
      // Arrange
      when(
        () => mockDataSource.fetchUserRegisteredEvents(
          any(),
          byDate: any(named: 'byDate'),
          byStatus: any(named: 'byStatus'),
          byLocationType: any(named: 'byLocationType'),
        ),
      ).thenAnswer((_) async => [testEventModel]);

      // Act
      await repository.getUserRegisteredEvents(
        testUserId,
        byDate: testDate,
        byStatus: [EventStatus.upcoming],
        byLocationType: EventLocationType.online,
      );

      // Assert
      verify(
        () => mockDataSource.fetchUserRegisteredEvents(
          testUserId,
          byDate: testDate,
          byStatus: [EventStatus.upcoming],
          byLocationType: EventLocationType.online,
        ),
      ).called(1);
    });

    test('should throw EventsException when data source throws an exception',
        () async {
      // Arrange
      when(
        () => mockDataSource.fetchUserRegisteredEvents(
          any(),
          byDate: any(named: 'byDate'),
          byStatus: any(named: 'byStatus'),
          byLocationType: any(named: 'byLocationType'),
        ),
      ).thenThrow(Exception('Test error'));

      // Act & Assert
      expect(
        () => repository.getUserRegisteredEvents(testUserId),
        throwsA(isA<EventsException>()),
      );
    });
  });

  group('registerUserForEvent', () {
    const testUserId = 'user1';
    const testEventId = 'event1';
    const testticketCount = 1;

    test('should call data source to register user for event', () async {
      // Arrange
      when(
        () => mockDataSource.addUserToEventAttendees(
          eventId: any(named: 'eventId'),
          userId: any(named: 'userId'),
          ticketCount: any(named: 'ticketCount'),
        ),
      ).thenAnswer((_) async => testEventModel);

      // Act
      await repository.registerUserForEvent(
        eventId: testEventId,
        userId: testUserId,
        ticketCount: testticketCount,
      );

      // Assert
      verify(
        () => mockDataSource.addUserToEventAttendees(
          eventId: testEventId,
          userId: testUserId,
          ticketCount: testticketCount,
        ),
      ).called(1);
    });

    test('should throw EventsException when data source throws an exception',
        () async {
      // Arrange
      when(
        () => mockDataSource.addUserToEventAttendees(
          eventId: any(named: 'eventId'),
          userId: any(named: 'userId'),
          ticketCount: any(named: 'ticketCount'),
        ),
      ).thenThrow(Exception('Test error'));

      // Act & Assert
      expect(
        () => repository.registerUserForEvent(
          eventId: testEventId,
          userId: testUserId,
          ticketCount: testticketCount,
        ),
        throwsA(isA<EventsException>()),
      );
    });
  });
}
