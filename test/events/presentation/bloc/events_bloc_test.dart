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
}
