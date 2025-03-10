// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event_filter.dart';

class EventFilterMapper extends ClassMapperBase<EventFilter> {
  EventFilterMapper._();

  static EventFilterMapper? _instance;
  static EventFilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventFilterMapper._());
      EventStatusMapper.ensureInitialized();
      EventLocationTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EventFilter';

  static DateTime? _$timeFilter(EventFilter v) => v.timeFilter;
  static const Field<EventFilter, DateTime> _f$timeFilter =
      Field('timeFilter', _$timeFilter, opt: true);
  static List<EventStatus> _$status(EventFilter v) => v.status;
  static const Field<EventFilter, List<EventStatus>> _f$status =
      Field('status', _$status, opt: true, def: const []);
  static EventLocationType? _$eventType(EventFilter v) => v.eventType;
  static const Field<EventFilter, EventLocationType> _f$eventType =
      Field('eventType', _$eventType, opt: true);

  @override
  final MappableFields<EventFilter> fields = const {
    #timeFilter: _f$timeFilter,
    #status: _f$status,
    #eventType: _f$eventType,
  };

  static EventFilter _instantiate(DecodingData data) {
    return EventFilter(
        timeFilter: data.dec(_f$timeFilter),
        status: data.dec(_f$status),
        eventType: data.dec(_f$eventType));
  }

  @override
  final Function instantiate = _instantiate;

  static EventFilter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventFilter>(map);
  }

  static EventFilter fromJson(String json) {
    return ensureInitialized().decodeJson<EventFilter>(json);
  }
}

mixin EventFilterMappable {
  String toJson() {
    return EventFilterMapper.ensureInitialized()
        .encodeJson<EventFilter>(this as EventFilter);
  }

  Map<String, dynamic> toMap() {
    return EventFilterMapper.ensureInitialized()
        .encodeMap<EventFilter>(this as EventFilter);
  }

  EventFilterCopyWith<EventFilter, EventFilter, EventFilter> get copyWith =>
      _EventFilterCopyWithImpl(this as EventFilter, $identity, $identity);
  @override
  String toString() {
    return EventFilterMapper.ensureInitialized()
        .stringifyValue(this as EventFilter);
  }

  @override
  bool operator ==(Object other) {
    return EventFilterMapper.ensureInitialized()
        .equalsValue(this as EventFilter, other);
  }

  @override
  int get hashCode {
    return EventFilterMapper.ensureInitialized().hashValue(this as EventFilter);
  }
}

extension EventFilterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventFilter, $Out> {
  EventFilterCopyWith<$R, EventFilter, $Out> get $asEventFilter =>
      $base.as((v, t, t2) => _EventFilterCopyWithImpl(v, t, t2));
}

abstract class EventFilterCopyWith<$R, $In extends EventFilter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, EventStatus, ObjectCopyWith<$R, EventStatus, EventStatus>>
      get status;
  $R call(
      {DateTime? timeFilter,
      List<EventStatus>? status,
      EventLocationType? eventType});
  EventFilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventFilterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventFilter, $Out>
    implements EventFilterCopyWith<$R, EventFilter, $Out> {
  _EventFilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventFilter> $mapper =
      EventFilterMapper.ensureInitialized();
  @override
  ListCopyWith<$R, EventStatus, ObjectCopyWith<$R, EventStatus, EventStatus>>
      get status => ListCopyWith($value.status,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(status: v));
  @override
  $R call(
          {Object? timeFilter = $none,
          List<EventStatus>? status,
          Object? eventType = $none}) =>
      $apply(FieldCopyWithData({
        if (timeFilter != $none) #timeFilter: timeFilter,
        if (status != null) #status: status,
        if (eventType != $none) #eventType: eventType
      }));
  @override
  EventFilter $make(CopyWithData data) => EventFilter(
      timeFilter: data.get(#timeFilter, or: $value.timeFilter),
      status: data.get(#status, or: $value.status),
      eventType: data.get(#eventType, or: $value.eventType));

  @override
  EventFilterCopyWith<$R2, EventFilter, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EventFilterCopyWithImpl($value, $cast, t);
}
