// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event_model.dart';

class EventModelMapper extends ClassMapperBase<EventModel> {
  EventModelMapper._();

  static EventModelMapper? _instance;
  static EventModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventModelMapper._());
      EventTicketTypeMapper.ensureInitialized();
      EventStatusMapper.ensureInitialized();
      EventLocationTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EventModel';

  static String _$id(EventModel v) => v.id;
  static const Field<EventModel, String> _f$id = Field('id', _$id);
  static String _$title(EventModel v) => v.title;
  static const Field<EventModel, String> _f$title = Field('title', _$title);
  static DateTime _$endDate(EventModel v) => v.endDate;
  static const Field<EventModel, DateTime> _f$endDate =
      Field('endDate', _$endDate);
  static DateTime _$startDate(EventModel v) => v.startDate;
  static const Field<EventModel, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static EventTicketType _$ticketType(EventModel v) => v.ticketType;
  static const Field<EventModel, EventTicketType> _f$ticketType =
      Field('ticketType', _$ticketType);
  static EventStatus _$status(EventModel v) => v.status;
  static const Field<EventModel, EventStatus> _f$status =
      Field('status', _$status);
  static EventLocationType _$type(EventModel v) => v.type;
  static const Field<EventModel, EventLocationType> _f$type =
      Field('type', _$type);
  static String _$description(EventModel v) => v.description;
  static const Field<EventModel, String> _f$description =
      Field('description', _$description);
  static double? _$rating(EventModel v) => v.rating;
  static const Field<EventModel, double> _f$rating = Field('rating', _$rating);
  static String? _$pictureUrl(EventModel v) => v.pictureUrl;
  static const Field<EventModel, String> _f$pictureUrl =
      Field('pictureUrl', _$pictureUrl);
  static double _$pricing(EventModel v) => v.pricing;
  static const Field<EventModel, double> _f$pricing =
      Field('pricing', _$pricing);
  static String? _$location(EventModel v) => v.location;
  static const Field<EventModel, String> _f$location =
      Field('location', _$location);
  static List<String>? _$attendeeIDs(EventModel v) => v.attendeeIDs;
  static const Field<EventModel, List<String>> _f$attendeeIDs =
      Field('attendeeIDs', _$attendeeIDs, opt: true);
  static DateTime? _$_createdAt(EventModel v) => v._createdAt;
  static const Field<EventModel, DateTime> _f$_createdAt =
      Field('_createdAt', _$_createdAt, key: r'createdAt', opt: true);

  @override
  final MappableFields<EventModel> fields = const {
    #id: _f$id,
    #title: _f$title,
    #endDate: _f$endDate,
    #startDate: _f$startDate,
    #ticketType: _f$ticketType,
    #status: _f$status,
    #type: _f$type,
    #description: _f$description,
    #rating: _f$rating,
    #pictureUrl: _f$pictureUrl,
    #pricing: _f$pricing,
    #location: _f$location,
    #attendeeIDs: _f$attendeeIDs,
    #_createdAt: _f$_createdAt,
  };

  static EventModel _instantiate(DecodingData data) {
    return EventModel(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        endDate: data.dec(_f$endDate),
        startDate: data.dec(_f$startDate),
        ticketType: data.dec(_f$ticketType),
        status: data.dec(_f$status),
        type: data.dec(_f$type),
        description: data.dec(_f$description),
        rating: data.dec(_f$rating),
        pictureUrl: data.dec(_f$pictureUrl),
        pricing: data.dec(_f$pricing),
        location: data.dec(_f$location),
        attendeeIDs: data.dec(_f$attendeeIDs),
        createdAt: data.dec(_f$_createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static EventModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventModel>(map);
  }

  static EventModel fromJson(String json) {
    return ensureInitialized().decodeJson<EventModel>(json);
  }
}

mixin EventModelMappable {
  String toJson() {
    return EventModelMapper.ensureInitialized()
        .encodeJson<EventModel>(this as EventModel);
  }

  Map<String, dynamic> toMap() {
    return EventModelMapper.ensureInitialized()
        .encodeMap<EventModel>(this as EventModel);
  }

  EventModelCopyWith<EventModel, EventModel, EventModel> get copyWith =>
      _EventModelCopyWithImpl(this as EventModel, $identity, $identity);
  @override
  String toString() {
    return EventModelMapper.ensureInitialized()
        .stringifyValue(this as EventModel);
  }

  @override
  bool operator ==(Object other) {
    return EventModelMapper.ensureInitialized()
        .equalsValue(this as EventModel, other);
  }

  @override
  int get hashCode {
    return EventModelMapper.ensureInitialized().hashValue(this as EventModel);
  }
}

extension EventModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventModel, $Out> {
  EventModelCopyWith<$R, EventModel, $Out> get $asEventModel =>
      $base.as((v, t, t2) => _EventModelCopyWithImpl(v, t, t2));
}

abstract class EventModelCopyWith<$R, $In extends EventModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get attendeeIDs;
  $R call(
      {String? id,
      String? title,
      DateTime? endDate,
      DateTime? startDate,
      EventTicketType? ticketType,
      EventStatus? status,
      EventLocationType? type,
      String? description,
      double? rating,
      String? pictureUrl,
      double? pricing,
      String? location,
      List<String>? attendeeIDs,
      DateTime? createdAt});
  EventModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventModel, $Out>
    implements EventModelCopyWith<$R, EventModel, $Out> {
  _EventModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventModel> $mapper =
      EventModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get attendeeIDs => $value.attendeeIDs != null
          ? ListCopyWith(
              $value.attendeeIDs!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(attendeeIDs: v))
          : null;
  @override
  $R call(
          {String? id,
          String? title,
          DateTime? endDate,
          DateTime? startDate,
          EventTicketType? ticketType,
          EventStatus? status,
          EventLocationType? type,
          String? description,
          Object? rating = $none,
          Object? pictureUrl = $none,
          double? pricing,
          Object? location = $none,
          Object? attendeeIDs = $none,
          Object? createdAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (endDate != null) #endDate: endDate,
        if (startDate != null) #startDate: startDate,
        if (ticketType != null) #ticketType: ticketType,
        if (status != null) #status: status,
        if (type != null) #type: type,
        if (description != null) #description: description,
        if (rating != $none) #rating: rating,
        if (pictureUrl != $none) #pictureUrl: pictureUrl,
        if (pricing != null) #pricing: pricing,
        if (location != $none) #location: location,
        if (attendeeIDs != $none) #attendeeIDs: attendeeIDs,
        if (createdAt != $none) #createdAt: createdAt
      }));
  @override
  EventModel $make(CopyWithData data) => EventModel(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      endDate: data.get(#endDate, or: $value.endDate),
      startDate: data.get(#startDate, or: $value.startDate),
      ticketType: data.get(#ticketType, or: $value.ticketType),
      status: data.get(#status, or: $value.status),
      type: data.get(#type, or: $value.type),
      description: data.get(#description, or: $value.description),
      rating: data.get(#rating, or: $value.rating),
      pictureUrl: data.get(#pictureUrl, or: $value.pictureUrl),
      pricing: data.get(#pricing, or: $value.pricing),
      location: data.get(#location, or: $value.location),
      attendeeIDs: data.get(#attendeeIDs, or: $value.attendeeIDs),
      createdAt: data.get(#createdAt, or: $value._createdAt));

  @override
  EventModelCopyWith<$R2, EventModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EventModelCopyWithImpl($value, $cast, t);
}
