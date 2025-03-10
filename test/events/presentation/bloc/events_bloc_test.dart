// ignore_for_file: unawaited_futures, lines_longer_than_80_chars, void_checks

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repat_event/core/errors/use_case_failure.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';

import 'package:repat_event/features/events/domain/usecases/add_booking_use_case.dart';
import 'package:repat_event/features/events/domain/usecases/cancel_booking_use_case.dart';
import 'package:repat_event/features/events/domain/usecases/get_events_use_case.dart';
import 'package:repat_event/features/events/presentation/bloc/events_bloc.dart';
import 'package:repat_event/locator.dart';

class MockGetEventsUseCase extends Mock implements GetEventsUseCase {}

class MockGetRegisteredEventsUseCase extends Mock
    implements GetRegisteredEventsUseCase {}

class MockAddBookingUseCase extends Mock implements AddBookingUseCase {}

class MockCancelBookingUseCase extends Mock implements CancelBookingUseCase {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  setUpAll(() {
    registerFallbackValue(const GetEventsUseCaseParams());
    registerFallbackValue(const GetRegisteredEventParams(userId: 'dummy-id'));
    registerFallbackValue(
      const AddBookingParams(
        eventId: 'dummy-id',
        userId: 'dummy-id',
        ticketCount: 1,
      ),
    );
    registerFallbackValue(
      const CancelBookingParams(
        eventId: 'dummy-id',
        userId: 'dummy-id',
      ),
    );
  });

  late EventsBloc eventsBloc;
  late MockGetEventsUseCase mockGetEventsUseCase;
  late MockGetRegisteredEventsUseCase mockGetRegisteredEventsUseCase;
  late MockAddBookingUseCase mockAddBookingUseCase;
  late MockCancelBookingUseCase mockCancelBookingUseCase;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;

  const testUserId = 'test-user-id';
  final now = DateTime.now();
  final testEvents = [
    Event(
      id: '1',
      title: 'Test Event 1',
      description: 'Description 1',
      location: 'Location 1',
      startDate: now,
      endDate: now.add(const Duration(hours: 3)),
      pictureUrl: 'image1.jpg',
      pricing: 100,
      status: EventStatus.upcoming,
      ticketType: EventTicketType.free,
      type: EventLocationType.online,
    ),
    Event(
      id: '2',
      title: 'Test Event 2',
      description: 'Description 2',
      location: 'Location 2',
      startDate: now,
      endDate: now.add(const Duration(hours: 3)),
      pictureUrl: 'image2.jpg',
      pricing: 200,
      status: EventStatus.upcoming,
      ticketType: EventTicketType.paid,
      type: EventLocationType.offline,
    ),
  ];

  setUp(() {
    mockGetEventsUseCase = MockGetEventsUseCase();
    mockGetRegisteredEventsUseCase = MockGetRegisteredEventsUseCase();
    mockAddBookingUseCase = MockAddBookingUseCase();
    mockCancelBookingUseCase = MockCancelBookingUseCase();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();

    when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(testUserId);

    when(() => mockGetEventsUseCase.call(any())).thenAnswer(
      (_) async => Right(testEvents),
    );

    when(() => mockGetRegisteredEventsUseCase.call(any())).thenAnswer(
      (_) async => Right(testEvents),
    );

    when(() => mockAddBookingUseCase.call(any())).thenAnswer(
      (_) async => const Right(true),
    );

    when(() => mockCancelBookingUseCase.call(any())).thenAnswer(
      (_) async => const Right(true),
    );

    locator
      ..registerFactory<GetEventsUseCase>(() => mockGetEventsUseCase)
      ..registerFactory<GetRegisteredEventsUseCase>(
        () => mockGetRegisteredEventsUseCase,
      )
      ..registerFactory<AddBookingUseCase>(() => mockAddBookingUseCase)
      ..registerFactory<CancelBookingUseCase>(() => mockCancelBookingUseCase)
      ..registerFactory<FirebaseAuth>(() => mockFirebaseAuth);

    eventsBloc = EventsBloc();
  });

  tearDown(() {
    eventsBloc.close();
    locator.reset();
  });

  group('EventsFetchEvent', () {
    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsFetchSuccessState] when fetching events succeeds',
      build: () => eventsBloc,
      act: (bloc) => bloc.add(const EventsFetchEvent()),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsFetchSuccessState>().having(
          (state) => state.events,
          'events',
          testEvents,
        ),
      ],
    );

    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsFetchFailedState] when fetching events fails',
      build: () {
        when(() => mockGetEventsUseCase.call(any())).thenAnswer(
          (_) async => Left(EventsFetchFailure()),
        );
        return eventsBloc;
      },
      act: (bloc) => bloc.add(const EventsFetchEvent()),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsFetchFailedState>(),
      ],
    );
  });

  group('EventsFetchRegisteredEvent', () {
    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsFetchSuccessState] when fetching registered events succeeds',
      build: () => eventsBloc,
      act: (bloc) => bloc.add(const EventsFetchRegisteredEvent()),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsFetchSuccessState>().having(
          (state) => state.events,
          'events',
          testEvents,
        ),
      ],
    );

    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsFetchFailedState] when fetching registered events fails',
      build: () {
        when(() => mockGetRegisteredEventsUseCase.call(any())).thenAnswer(
          (_) async => Left(EventsFetchFailure()),
        );
        return eventsBloc;
      },
      act: (bloc) => bloc.add(const EventsFetchRegisteredEvent()),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsFetchFailedState>(),
      ],
    );
  });

  group('EventsAddBookingEvent', () {
    const testEventId = '1';
    const testTicketCount = 2;

    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsInitial] when adding booking succeeds',
      build: () => eventsBloc,
      act: (bloc) => bloc.add(
        const EventsAddBookingEvent(
          eventId: testEventId,
          ticketCount: testTicketCount,
        ),
      ),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsInitial>(),
      ],
    );

    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsFetchFailedState] when adding booking fails',
      build: () {
        when(() => mockAddBookingUseCase.call(any())).thenAnswer(
          (_) async => Left(EventsFetchFailure()),
        );
        return eventsBloc;
      },
      act: (bloc) => bloc.add(
        const EventsAddBookingEvent(
          eventId: testEventId,
          ticketCount: testTicketCount,
        ),
      ),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsFetchFailedState>(),
      ],
    );
  });

  group('EventsCancelBookingEvent', () {
    const testEventId = '1';
    const testReason = 'Test reason';

    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsInitial] when canceling booking succeeds',
      build: () => eventsBloc,
      act: (bloc) => bloc.add(
        const EventsCancelBookingEvent(
          eventId: testEventId,
          reason: testReason,
        ),
      ),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsInitial>(),
      ],
    );

    blocTest<EventsBloc, EventsState>(
      'emits [EventsLoading, EventsFetchFailedState] when canceling booking fails',
      build: () {
        when(() => mockCancelBookingUseCase.call(any())).thenAnswer(
          (_) async => Left(EventsFetchFailure()),
        );
        return eventsBloc;
      },
      act: (bloc) => bloc.add(
        const EventsCancelBookingEvent(
          eventId: testEventId,
          reason: testReason,
        ),
      ),
      expect: () => [
        isA<EventsLoading>(),
        isA<EventsFetchFailedState>(),
      ],
    );
  });
}
