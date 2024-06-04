// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'username.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserName extends UserName {
  @override
  final String value;

  factory _$UserName([void Function(UserNameBuilder)? updates]) =>
      (new UserNameBuilder()..update(updates))._build();

  _$UserName._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'UserName', 'value');
  }

  @override
  UserName rebuild(void Function(UserNameBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserNameBuilder toBuilder() => new UserNameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserName && value == other.value;
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
    return (newBuiltValueToStringHelper(r'UserName')..add('value', value))
        .toString();
  }
}

class UserNameBuilder implements Builder<UserName, UserNameBuilder> {
  _$UserName? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  UserNameBuilder();

  UserNameBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserName other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserName;
  }

  @override
  void update(void Function(UserNameBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserName build() => _build();

  _$UserName _build() {
    final _$result = _$v ??
        new _$UserName._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'UserName', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
