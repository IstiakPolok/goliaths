part of '../_pages.dart';

class ControllerBirthDay extends GetxController {
  final todays = RxList<BirthdayItem>([]);
  final upcomings = RxList<BirthdayItem>([]);

  final sectionsDummy = const [
    BirthdayItem(
      name: 'Susan Zannat',
      birthday: '4/15/2026',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'Mark Taylor',
      birthday: '4/29/2027',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'Mark Butcher',
      birthday: '4/29/2027',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'Tushfiqur Bahim',
      birthday: '4/29/2027',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'Mashrafi Bin Tortoja',
      birthday: '4/29/2027',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'Alice Cooper',
      birthday: '5/5/2028',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'John Doe',
      birthday: '12/12/2025',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'Susan Zannat',
      birthday: '1/30/2027',
      image: 'https://avatar.iran.liara.run/public',
    ),
    BirthdayItem(
      name: 'Jane Smith',
      birthday: '6/18/2026',
      image: 'https://avatar.iran.liara.run/public',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    groupBirthDayList(sectionsDummy);
  }

  void groupBirthDayList(List<BirthdayItem> allBirthdays) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    List<BirthdayItem> birthdaysToday = [];
    List<BirthdayItem> upcomingBirthdays = [];

    for (var item in allBirthdays) {
      final date = item.parsedDate;
      final birthdayThisYear = DateTime(today.year, date.month, date.day);

      if (birthdayThisYear.month == today.month &&
          birthdayThisYear.day == today.day) {
        birthdaysToday.add(item);
      } else {
        final difference = birthdayThisYear.difference(today).inDays;
        if (difference >= 0 && difference <= 365) {
          upcomingBirthdays.add(item);
        }
      }
    }
    if (birthdaysToday.isNotEmpty) todays.value = birthdaysToday;
    if (upcomingBirthdays.isNotEmpty) upcomings.value = upcomingBirthdays;
  }
}
