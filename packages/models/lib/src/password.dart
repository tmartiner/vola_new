import 'package:built_value/built_value.dart';

part 'password.g.dart';

enum PasswordStatus { unknown, valid, invalid }

abstract class Password implements Built<Password, PasswordBuilder> {
  String get value;

  Password._() {
    if (value.length < 8) {
      throw ArgumentError('Password must be at least 8 characters');
    }

    final RegExp passwordRegExp = RegExp(
      r'(?=.{8,})(?=[A-Z].*[a-z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z].*[a-z])',
      //r'^[a-zA-Z0-9]*$',
    );

    if (!passwordRegExp.hasMatch(value)) {
      throw ArgumentError(
          'Must have special signs and alpha numeric caracters');
    }
  }
  factory Password([void Function(PasswordBuilder) updates]) = _$Password;
}
