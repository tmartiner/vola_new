import 'package:built_value/built_value.dart';

part 'bio.g.dart';

enum BioStatus { unknown, valid, invalid }

abstract class Bio implements Built<Bio, BioBuilder> {
  String get value;

  Bio._() {
    final RegExp bioRegExp = RegExp(r'^.{15,}$');

    if (!bioRegExp.hasMatch(value)) {
      throw ArgumentError(
          'Bio must be at least 20 characters and contain no special characters');
    }
  }
  factory Bio([void Function(BioBuilder) updates]) = _$Bio;
}
