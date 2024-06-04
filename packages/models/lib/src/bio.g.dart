// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bio.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Bio extends Bio {
  @override
  final String value;

  factory _$Bio([void Function(BioBuilder)? updates]) =>
      (new BioBuilder()..update(updates))._build();

  _$Bio._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'Bio', 'value');
  }

  @override
  Bio rebuild(void Function(BioBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BioBuilder toBuilder() => new BioBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bio && value == other.value;
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
    return (newBuiltValueToStringHelper(r'Bio')..add('value', value))
        .toString();
  }
}

class BioBuilder implements Builder<Bio, BioBuilder> {
  _$Bio? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  BioBuilder();

  BioBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Bio other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Bio;
  }

  @override
  void update(void Function(BioBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Bio build() => _build();

  _$Bio _build() {
    final _$result = _$v ??
        new _$Bio._(
            value:
                BuiltValueNullFieldError.checkNotNull(value, r'Bio', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
