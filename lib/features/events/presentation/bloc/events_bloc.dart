import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/domain/entities/event_filter.dart';
import 'package:repat_event/features/events/domain/usecases/add_booking_use_case.dart';
import 'package:repat_event/features/events/domain/usecases/cancel_booking_use_case.dart';
import 'package:repat_event/features/events/domain/usecases/get_events_use_case.dart';
import 'package:repat_event/locator.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<EventsFetchEvent>((event, emit) async {
      final useCase = locator<GetEventsUseCase>();

      emit(EventsLoading());
      activeFilter = event.filter ?? activeFilter;

      (await useCase.call(
        GetEventsUseCaseParams(
          filter: activeFilter,
        ),
      ))
          .fold(
        (failure) => emit(const EventsFetchFailedState()),
        (events) {
          emit(EventsFetchSuccessState(events: events));
        },
      );
    });

    on<EventsFetchRegisteredEvent>((event, emit) async {
      final useCase = locator<GetRegisteredEventsUseCase>();

      emit(EventsLoading());

      final auth = locator<FirebaseAuth>();
      final userId = auth.currentUser!.uid;

      (await useCase.call(
        GetRegisteredEventParams(
          userId: userId,
        ),
      ))
          .fold(
        (failure) => emit(const EventsFetchFailedState()),
        (events) {
          emit(
            EventsFetchSuccessState(
              events: events,
            ),
          );
        },
      );
    });

    on<EventsCancelBookingEvent>((event, emit) async {
      final useCase = locator<CancelBookingUseCase>();

      emit(EventsLoading());

      final auth = locator<FirebaseAuth>();
      final userId = auth.currentUser!.uid;

      final result = await useCase.call(
        CancelBookingParams(
          eventId: event.eventId,
          userId: userId,
          reason: event.reason,
        ),
      );

      result.fold(
        (failure) {
          emit(const EventsFetchFailedState());
          event.onError?.call();
        },
        (success) {
          emit(EventsInitial());
          event.onSuccess?.call();
        },
      );
    });

    on<EventsAddBookingEvent>((event, emit) async {
      final useCase = locator<AddBookingUseCase>();

      emit(EventsLoading());

      final auth = locator<FirebaseAuth>();
      final userId = auth.currentUser!.uid;

      final result = await useCase.call(
        AddBookingParams(
          eventId: event.eventId,
          userId: userId,
          ticketCount: event.ticketCount,
        ),
      );

      result.fold(
        (failure) {
          emit(const EventsFetchFailedState());
          event.onError?.call();
        },
        (success) {
          emit(EventsInitial());
          event.onSuccess?.call();
        },
      );
    });
  }

  EventFilter? activeFilter;
}
