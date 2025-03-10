import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:repat_event/core/errors/use_case_failure.dart';
import 'package:repat_event/core/usecases/usecase.dart';
import 'package:repat_event/features/events/domain/repositories/events_repository.dart';

class CancelBookingUseCase implements UseCase<void, CancelBookingParams> {
  const CancelBookingUseCase(
    this.repository,
  );

  final EventsRepository repository;

  @override
  String get identifier => 'cancel_booking_use_case';

  @override
  Future<Either<Failure, void>> call(CancelBookingParams params) async {
    try {
      await repository.cancelUserBookingFromEvent(
        eventId: params.eventId,
        userId: params.userId,
        reason: params.reason,
      );

      return const Right(null);
    } catch (e) {
      return Left(EventsFetchFailure());
    }
  }
}

class CancelBookingParams extends Equatable {
  const CancelBookingParams({
    required this.eventId,
    required this.userId,
    this.reason,
  });

  final String eventId;
  final String userId;
  final String? reason;

  @override
  List<Object?> get props => [eventId, userId, reason];
}
