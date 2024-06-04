import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toCustomFormat() {
    return DateFormat('d MMMM y').format(this);
  }

  String toCustomDateTimeFormat() {
    return DateFormat('d MMM, HH:mm').format(this);
  }
}
