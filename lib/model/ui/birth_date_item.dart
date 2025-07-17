part of '../_models.dart';

class BirthdayItem {
  final String name;
  final String birthday;
  final String image;

  const BirthdayItem({
    required this.name,
    required this.birthday,
    required this.image,
  });

  DateTime get parsedDate {
    try {
      return DateTime.parse(birthday); // preferred: 'yyyy-MM-dd'
    } catch (_) {
      final parts = birthday.split('/');
      return DateTime(int.parse(parts[2]), int.parse(parts[0]), int.parse(parts[1]));
    }
  }
}

