import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repat_event/core/usecases/usecase.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
import 'package:repat_event/features/events/domain/usecases/get_events_use_case.dart';
import 'package:repat_event/locator.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<EventsFetchEvents>((event, emit) async {
      final useCase = locator<GetEventsUseCase>();

      emit(EventsLoading());

      (await useCase.call(NoParams())).fold(
        (failure) => emit(const EventsFetchFailedState()),
        (events) {
          emit(EventsFetchSuccessState(events: events));
        },
      );
    });

    on<EventsFetchRegisteredEvents>((event, emit) async {
      final useCase = locator<GetRegisteredEventsUseCase>();

      emit(EventsLoading());

      (await useCase.call(
        GetRegisteredEventParams(
          userId: FirebaseAuth.instance.currentUser!.uid,
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
  }
}
