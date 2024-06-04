extension StringExtensions on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }
}
