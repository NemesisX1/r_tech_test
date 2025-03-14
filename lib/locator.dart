import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:repat_event/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:repat_event/features/events/data/datasources/events_firestore_data_source_impl.dart';
import 'package:repat_event/features/events/data/repositories/events_repository_impl.dart';
import 'package:repat_event/features/events/domain/usecases/add_booking_use_case.dart';
import 'package:repat_event/features/events/domain/usecases/cancel_booking_use_case.dart';
import 'package:repat_event/features/events/domain/usecases/get_events_use_case.dart';
import 'package:repat_event/features/events/presentation/bloc/events_bloc.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator
    //// Blocs
    ..registerFactory(
      AuthCubit.new,
    )
    ..registerFactory(
      EventsBloc.new,
    )

    /// Db
    ..registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    )

    /// Datasources
    ..registerLazySingleton<EventsFirestoreDataSource>(
      () => EventsFirestoreDataSource(
        locator<FirebaseFirestore>(),
      ),
    )

    /// Repositories
    ..registerLazySingleton<EventsRepositoryImpl>(
      () => EventsRepositoryImpl(
        locator<EventsFirestoreDataSource>(),
      ),
    )

    /// Use Cases
    ..registerLazySingleton<GetEventsUseCase>(
      () => GetEventsUseCase(
        locator<EventsRepositoryImpl>(),
      ),
    )
    ..registerLazySingleton<GetRegisteredEventsUseCase>(
      () => GetRegisteredEventsUseCase(
        locator<EventsRepositoryImpl>(),
      ),
    )
    ..registerLazySingleton<CancelBookingUseCase>(
      () => CancelBookingUseCase(
        locator<EventsRepositoryImpl>(),
      ),
    )
    ..registerLazySingleton<AddBookingUseCase>(
      () => AddBookingUseCase(
        locator<EventsRepositoryImpl>(),
      ),
    );
}
