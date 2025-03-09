part of 'events_bloc.dart';

sealed class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

final class EventsFetchEvents extends EventsEvent {
  const EventsFetchEvents();
}

final class EventsFetchRegisteredEvents extends EventsEvent {
  const EventsFetchRegisteredEvents();
}
