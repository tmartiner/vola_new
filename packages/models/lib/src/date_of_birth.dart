import 'package:built_value/built_value.dart';

part 'date_of_birth.g.dart';

enum DateOfBirthStatus { unknown, valid, invalid }

abstract class DateOfBirth implements Built<DateOfBirth, DateOfBirthBuilder> {
  DateTime get value;

  DateOfBirth._() {
    if (value.isBefore(DateTime(1900, 1, 1))) {
      throw ArgumentError('Date of birth cannot be before 1st Jan 1900.');
    }

    if (value.isAfter(DateTime.now())) {
      throw ArgumentError('Date of birth cannot be in the future.');
    }
  }

  factory DateOfBirth([void Function(DateOfBirthBuilder) updates]) =
      _$DateOfBirth;
}
