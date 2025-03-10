import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:repat_event/core/errors/use_case_failure.dart';
import 'package:repat_event/core/usecases/usecase.dart';
import 'package:repat_event/features/events/domain/repositories/events_repository.dart';

class AddBookingUseCase implements UseCase<void, AddBookingParams> {
  const AddBookingUseCase(
    this.repository,
  );

  final EventsRepository repository;

  @override
  String get identifier => 'add_booking_use_case';

  @override
  Future<Either<Failure, void>> call(AddBookingParams params) async {
    try {
      await repository.registerUserForEvent(
        eventId: params.eventId,
        userId: params.userId,
        ticketCount: params.ticketCount,
      );

      return const Right(null);
    } catch (e) {
      return Left(EventsFetchFailure());
    }
  }
}

class AddBookingParams extends Equatable {
  const AddBookingParams({
    required this.eventId,
    required this.userId,
    required this.ticketCount,
  });

  final String eventId;
  final String userId;
  final int ticketCount;

  @override
  List<Object> get props => [eventId, userId, ticketCount];
}
