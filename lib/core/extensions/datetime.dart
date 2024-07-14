extension DateTimeExtension on DateTime {
  static DateTime fromJson(Map<String, dynamic> json) {
    return DateTime(
      json['year'] as int,
      json['month'] as int,
      json['day'] as int,
      json['hour'] as int,
      json['minute'] as int,
      json['second'] as int,
    );
  }
}
