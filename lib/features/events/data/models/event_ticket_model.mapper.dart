// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event_ticket_model.dart';

class EventTicketModelMapper extends ClassMapperBase<EventTicketModel> {
  EventTicketModelMapper._();

  static EventTicketModelMapper? _instance;
  static EventTicketModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventTicketModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventTicketModel';

  static String _$eventId(EventTicketModel v) => v.eventId;
  static const Field<EventTicketModel, String> _f$eventId =
      Field('eventId', _$eventId);
  static String _$userId(EventTicketModel v) => v.userId;
  static const Field<EventTicketModel, String> _f$userId =
      Field('userId', _$userId);
  static int _$ticketCount(EventTicketModel v) => v.ticketCount;
  static const Field<EventTicketModel, int> _f$ticketCount =
      Field('ticketCount', _$ticketCount);
  static double _$price(EventTicketModel v) => v.price;
  static const Field<EventTicketModel, double> _f$price =
      Field('price', _$price);
  static DateTime? _$_createdAt(EventTicketModel v) => v._createdAt;
  static const Field<EventTicketModel, DateTime> _f$_createdAt =
      Field('_createdAt', _$_createdAt, key: r'createdAt', opt: true);

  @override
  final MappableFields<EventTicketModel> fields = const {
    #eventId: _f$eventId,
    #userId: _f$userId,
    #ticketCount: _f$ticketCount,
    #price: _f$price,
    #_createdAt: _f$_createdAt,
  };

  static EventTicketModel _instantiate(DecodingData data) {
    return EventTicketModel(
        eventId: data.dec(_f$eventId),
        userId: data.dec(_f$userId),
        ticketCount: data.dec(_f$ticketCount),
        price: data.dec(_f$price),
        createdAt: data.dec(_f$_createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static EventTicketModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventTicketModel>(map);
  }

  static EventTicketModel fromJson(String json) {
    return ensureInitialized().decodeJson<EventTicketModel>(json);
  }
}

mixin EventTicketModelMappable {
  String toJson() {
    return EventTicketModelMapper.ensureInitialized()
        .encodeJson<EventTicketModel>(this as EventTicketModel);
  }

  Map<String, dynamic> toMap() {
    return EventTicketModelMapper.ensureInitialized()
        .encodeMap<EventTicketModel>(this as EventTicketModel);
  }

  EventTicketModelCopyWith<EventTicketModel, EventTicketModel, EventTicketModel>
      get copyWith => _EventTicketModelCopyWithImpl(
          this as EventTicketModel, $identity, $identity);
  @override
  String toString() {
    return EventTicketModelMapper.ensureInitialized()
        .stringifyValue(this as EventTicketModel);
  }

  @override
  bool operator ==(Object other) {
    return EventTicketModelMapper.ensureInitialized()
        .equalsValue(this as EventTicketModel, other);
  }

  @override
  int get hashCode {
    return EventTicketModelMapper.ensureInitialized()
        .hashValue(this as EventTicketModel);
  }
}

extension EventTicketModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventTicketModel, $Out> {
  EventTicketModelCopyWith<$R, EventTicketModel, $Out>
      get $asEventTicketModel =>
          $base.as((v, t, t2) => _EventTicketModelCopyWithImpl(v, t, t2));
}

abstract class EventTicketModelCopyWith<$R, $In extends EventTicketModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? eventId,
      String? userId,
      int? ticketCount,
      double? price,
      DateTime? createdAt});
  EventTicketModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _EventTicketModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventTicketModel, $Out>
    implements EventTicketModelCopyWith<$R, EventTicketModel, $Out> {
  _EventTicketModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventTicketModel> $mapper =
      EventTicketModelMapper.ensureInitialized();
  @override
  $R call(
          {String? eventId,
          String? userId,
          int? ticketCount,
          double? price,
          Object? createdAt = $none}) =>
      $apply(FieldCopyWithData({
        if (eventId != null) #eventId: eventId,
        if (userId != null) #userId: userId,
        if (ticketCount != null) #ticketCount: ticketCount,
        if (price != null) #price: price,
        if (createdAt != $none) #createdAt: createdAt
      }));
  @override
  EventTicketModel $make(CopyWithData data) => EventTicketModel(
      eventId: data.get(#eventId, or: $value.eventId),
      userId: data.get(#userId, or: $value.userId),
      ticketCount: data.get(#ticketCount, or: $value.ticketCount),
      price: data.get(#price, or: $value.price),
      createdAt: data.get(#createdAt, or: $value._createdAt));

  @override
  EventTicketModelCopyWith<$R2, EventTicketModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EventTicketModelCopyWithImpl($value, $cast, t);
}
