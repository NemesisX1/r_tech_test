// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event.dart';

class EventStatusMapper extends EnumMapper<EventStatus> {
  EventStatusMapper._();

  static EventStatusMapper? _instance;
  static EventStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventStatusMapper._());
    }
    return _instance!;
  }

  static EventStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  EventStatus decode(dynamic value) {
    switch (value) {
      case 'paid':
        return EventStatus.paid;
      case 'completed':
        return EventStatus.completed;
      case 'canceled':
        return EventStatus.canceled;
      case 'upcoming':
        return EventStatus.upcoming;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(EventStatus self) {
    switch (self) {
      case EventStatus.paid:
        return 'paid';
      case EventStatus.completed:
        return 'completed';
      case EventStatus.canceled:
        return 'canceled';
      case EventStatus.upcoming:
        return 'upcoming';
    }
  }
}

extension EventStatusMapperExtension on EventStatus {
  String toValue() {
    EventStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<EventStatus>(this) as String;
  }
}

class EventTicketTypeMapper extends EnumMapper<EventTicketType> {
  EventTicketTypeMapper._();

  static EventTicketTypeMapper? _instance;
  static EventTicketTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventTicketTypeMapper._());
    }
    return _instance!;
  }

  static EventTicketType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  EventTicketType decode(dynamic value) {
    switch (value) {
      case 'free':
        return EventTicketType.free;
      case 'paid':
        return EventTicketType.paid;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(EventTicketType self) {
    switch (self) {
      case EventTicketType.free:
        return 'free';
      case EventTicketType.paid:
        return 'paid';
    }
  }
}

extension EventTicketTypeMapperExtension on EventTicketType {
  String toValue() {
    EventTicketTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<EventTicketType>(this) as String;
  }
}

class EventLocationTypeMapper extends EnumMapper<EventLocationType> {
  EventLocationTypeMapper._();

  static EventLocationTypeMapper? _instance;
  static EventLocationTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventLocationTypeMapper._());
    }
    return _instance!;
  }

  static EventLocationType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  EventLocationType decode(dynamic value) {
    switch (value) {
      case 'offline':
        return EventLocationType.offline;
      case 'online':
        return EventLocationType.online;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(EventLocationType self) {
    switch (self) {
      case EventLocationType.offline:
        return 'offline';
      case EventLocationType.online:
        return 'online';
    }
  }
}

extension EventLocationTypeMapperExtension on EventLocationType {
  String toValue() {
    EventLocationTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<EventLocationType>(this) as String;
  }
}
