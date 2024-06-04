import 'package:built_value/built_value.dart';

part 'name.g.dart';

enum NameStatus { unknown, valid, invalid }

abstract class Name implements Built<Name, NameBuilder> {
  String get value;

  Name._() {
    // Regular expression for validating a name
    final RegExp nameRegExp = RegExp(
      r'^[a-zA-Z0-9_ äëïöüÄËÏÖÜàéèîôûÀÉÈÎÔÛ]{4,25}$',
    );

    if (!nameRegExp.hasMatch(value)) {
      throw ArgumentError(
        'Invalid name format.',
      );
    }
  }
  factory Name([void Function(NameBuilder) updates]) = _$Name;
}
