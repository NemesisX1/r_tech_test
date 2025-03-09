import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repat_event/core/errors/use_case_failure.dart';
import 'package:repat_event/core/usecases/usecase.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/domain/usecases/get_events_use_case.dart';
import 'package:repat_event/features/events/presentation/bloc/events_bloc.dart';
import 'package:repat_event/locator.dart';

class MockGetEventsUseCase extends Mock implements GetEventsUseCase {}

class MockGetRegisteredEventsUseCase extends Mock
    implements GetRegisteredEventsUseCase {}

void main() {
  late EventsBloc eventsBloc;
  late MockGetEventsUseCase mockGetEventsUseCase;
  late MockGetRegisteredEventsUseCase mockGetRegisteredEventsUseCase;

  setUp(() {
    mockGetEventsUseCase = MockGetEventsUseCase();
    mockGetRegisteredEventsUseCase = MockGetRegisteredEventsUseCase();

    // Register the mocks with the service locator
    locator
      ..registerFactory<GetEventsUseCase>(() => mockGetEventsUseCase)
      ..registerFactory<GetRegisteredEventsUseCase>(
        () => mockGetRegisteredEventsUseCase,
      );

    eventsBloc = EventsBloc();
  });

  tearDown(() {
    eventsBloc.close();
    locator.reset();
  });

  group('EventsBloc', () {
    final tEvents = [
      Event(
        id: '1',
        title: 'Test Event 1',
        startDate: DateTime(2025, 3, 15),
        endDate: DateTime(2025, 3, 15),
        status: EventStatus.upcoming,
        ticketType: EventTicketType.free,
        type: EventLocationType.online,
        description: 'Test description',
      ),
      Event(
        id: '2',
        title: 'Test Event 2',
        startDate: DateTime(2025, 4, 20),
        endDate: DateTime(2025, 4, 20),
        status: EventStatus.upcoming,
        ticketType: EventTicketType.paid,
        type: EventLocationType.offline,
        pricing: 99.99,
        location: 'Test Location',
        description: 'Test description 2',
      ),
    ];

    test('initial state should be EventsInitial', () {
      expect(eventsBloc.state, isA<EventsInitial>());
    });

    group('EventsFetchEvents', () {
      blocTest<EventsBloc, EventsState>(
        'emits [EventsLoading, EventsFetchSuccessState] when EventsFetchEvents is added and usecase succeeds',
        build: () {
          when(() => mockGetEventsUseCase.call(any()))
              .thenAnswer((_) async => Right(tEvents));
          return eventsBloc;
        },
        act: (bloc) => bloc.add(const EventsFetchEvents()),
        expect: () => [
          isA<EventsLoading>(),
          isA<EventsFetchSuccessState>().having(
            (state) => state.events,
            'events',
            tEvents,
          ),
        ],
        verify: (_) {
          verify(() => mockGetEventsUseCase.call(NoParams())).called(1);
        },
      );

      blocTest<EventsBloc, EventsState>(
        'emits [EventsLoading, EventsFetchFailedState] when EventsFetchEvents is added and usecase fails',
        build: () {
          when(() => mockGetEventsUseCase.call(any()))
              .thenAnswer((_) async => Left(EventsFetchFailure()));
          return eventsBloc;
        },
        act: (bloc) => bloc.add(const EventsFetchEvents()),
        expect: () => [
          isA<EventsLoading>(),
          isA<EventsFetchFailedState>(),
        ],
        verify: (_) {
          verify(() => mockGetEventsUseCase.call(NoParams())).called(1);
        },
      );
    });

    group('EventsFetchRegisteredEvents', () {
      blocTest<EventsBloc, EventsState>(
        'emits [EventsLoading, EventsFetchSuccessState] when EventsFetchRegisteredEvents is added and usecase succeeds',
        build: () {
          when(() => mockGetRegisteredEventsUseCase.call(any()))
              .thenAnswer((_) async => Right(tEvents));
          return eventsBloc;
        },
        act: (bloc) => bloc.add(const EventsFetchRegisteredEvents()),
        expect: () => [
          isA<EventsLoading>(),
          isA<EventsFetchSuccessState>().having(
            (state) => state.events,
            'events',
            tEvents,
          ),
        ],
        verify: (_) {
          verify(() => mockGetRegisteredEventsUseCase.call(any())).called(1);
        },
      );

      blocTest<EventsBloc, EventsState>(
        'emits [EventsLoading, EventsFetchFailedState] when EventsFetchRegisteredEvents is added and usecase fails',
        build: () {
          when(() => mockGetRegisteredEventsUseCase.call(any()))
              .thenAnswer((_) async => Left(EventsFetchFailure()));
          return eventsBloc;
        },
        act: (bloc) => bloc.add(const EventsFetchRegisteredEvents()),
        expect: () => [
          isA<EventsLoading>(),
          isA<EventsFetchFailedState>(),
        ],
        verify: (_) {
          verify(() => mockGetRegisteredEventsUseCase.call(any())).called(1);
        },
      );
    });
  });
}
