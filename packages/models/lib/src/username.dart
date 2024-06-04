import 'package:built_value/built_value.dart';

part 'username.g.dart';

enum UserNameStatus { unknown, valid, invalid }

abstract class UserName implements Built<UserName, UserNameBuilder> {
  String get value;

  UserName._() {
    // Regular expression for validating a username
    final RegExp usernameRegExp = RegExp(
      r'^[A-Za-z0-9_-]{4,15}$',
    );

    if (!usernameRegExp.hasMatch(value)) {
      throw ArgumentError('Invalid username format');
    }
  }
  factory UserName([void Function(UserNameBuilder) updates]) = _$UserName;
}
