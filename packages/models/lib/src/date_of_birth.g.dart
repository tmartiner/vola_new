// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_of_birth.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DateOfBirth extends DateOfBirth {
  @override
  final DateTime value;

  factory _$DateOfBirth([void Function(DateOfBirthBuilder)? updates]) =>
      (new DateOfBirthBuilder()..update(updates))._build();

  _$DateOfBirth._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'DateOfBirth', 'value');
  }

  @override
  DateOfBirth rebuild(void Function(DateOfBirthBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DateOfBirthBuilder toBuilder() => new DateOfBirthBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateOfBirth && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DateOfBirth')..add('value', value))
        .toString();
  }
}

class DateOfBirthBuilder implements Builder<DateOfBirth, DateOfBirthBuilder> {
  _$DateOfBirth? _$v;

  DateTime? _value;
  DateTime? get value => _$this._value;
  set value(DateTime? value) => _$this._value = value;

  DateOfBirthBuilder();

  DateOfBirthBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateOfBirth other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DateOfBirth;
  }

  @override
  void update(void Function(DateOfBirthBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DateOfBirth build() => _build();

  _$DateOfBirth _build() {
    final _$result = _$v ??
        new _$DateOfBirth._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'DateOfBirth', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
