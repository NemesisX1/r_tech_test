import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:repat_event/features/events/domain/entities/event.dart';
part 'event_filter.mapper.dart';

@MappableClass()
class EventFilter extends Equatable with EventFilterMappable {
  const EventFilter({
    this.timeFilter,
    this.status = const [],
    this.eventType,
  });

  final DateTime? timeFilter;

  final List<EventStatus> status;

  final EventLocationType? eventType;

  bool get isEmpty => timeFilter == null && status.isEmpty && eventType == null;

  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [timeFilter, status, eventType];
}
