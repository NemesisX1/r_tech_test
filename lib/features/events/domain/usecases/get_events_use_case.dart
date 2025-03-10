import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:repat_event/core/errors/use_case_failure.dart';
import 'package:repat_event/core/usecases/usecase.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/domain/entities/event_filter.dart';
import 'package:repat_event/features/events/domain/repositories/events_repository.dart';

class GetEventsUseCase implements UseCase<List<Event>, GetEventsUseCaseParams> {
  const GetEventsUseCase(
    this.repository,
  );

  final EventsRepository repository;

  @override
  String get identifier => 'get_event_use_case';

  @override
  Future<Either<Failure, List<Event>>> call(
    GetEventsUseCaseParams params,
  ) async {
    try {
      final events = await repository.getEvents(
        byDate: params.filter?.timeFilter,
        byStatus: params.filter?.status,
        byLocationType: params.filter?.eventType,
      );

      return Right(events);
    } catch (e) {
      return Left(EventsFetchFailure());
    }
  }
}

class GetEventsUseCaseParams extends Equatable {
  const GetEventsUseCaseParams({
    this.filter,
  });

  final EventFilter? filter;

  @override
  List<Object> get props => [filter ?? const []];
}

class GetRegisteredEventsUseCase
    implements UseCase<List<Event>, GetRegisteredEventParams> {
  const GetRegisteredEventsUseCase(
    this.repository,
  );

  final EventsRepository repository;

  @override
  String get identifier => 'get_registered_event_use_case';

  @override
  Future<Either<Failure, List<Event>>> call(
    GetRegisteredEventParams params,
  ) async {
    try {
      final events = await repository.getUserRegisteredEvents(
        params.userId,
      );

      return Right(events);
    } catch (e) {
      return Left(EventsFetchFailure());
    }
  }
}

class GetRegisteredEventParams extends Equatable {
  const GetRegisteredEventParams({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [userId];
}
