part of 'events_bloc.dart';

sealed class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

final class EventsFetchEvent extends EventsEvent {
  const EventsFetchEvent({
    this.filter,
  });

  final EventFilter? filter;
}

final class EventsFetchRegisteredEvent extends EventsEvent {
  const EventsFetchRegisteredEvent();
}

final class EventsCancelBookingEvent extends EventsEvent {
  const EventsCancelBookingEvent({
    required this.eventId,
    this.reason,
    this.onSuccess,
    this.onError,
  });

  final String eventId;
  final String? reason;

  final VoidCallback? onError;
  final VoidCallback? onSuccess;
}

final class EventsAddBookingEvent extends EventsEvent {
  const EventsAddBookingEvent({
    required this.eventId,
    required this.ticketCount,
    this.onSuccess,
    this.onError,
  });

  final String eventId;
  final int ticketCount;

  final VoidCallback? onError;
  final VoidCallback? onSuccess;
}
