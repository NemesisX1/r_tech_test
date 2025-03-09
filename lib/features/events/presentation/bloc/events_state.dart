part of 'events_bloc.dart';

sealed class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

final class EventsInitial extends EventsState {}

final class EventsLoading extends EventsState {}

final class EventsFetchSuccessState extends EventsState {
  const EventsFetchSuccessState({
    required this.events,
  });

  final List<Event> events;

  @override
  List<Object> get props => [events];
}

final class EventsFetchFailedState extends EventsState {
  const EventsFetchFailedState();

  @override
  List<Object> get props => [];
}
