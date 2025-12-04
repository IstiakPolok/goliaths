part of '../_pages.dart';

/// ****************************************************************************
/// Onboard Date Birth Pick Screen
/// ****************************************************************************
class ScreenDob extends GetView<ControllerOnboard> {
  ScreenDob({super.key});

  final DobController dobController = Get.put(DobController());
  final ControllerBirthDay birthdayController = Get.put(ControllerBirthDay());
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final DateTime firstDate = DateTime(1900);
  final DateTime lastDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardAppBar(title: "What is your date of birth?"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Month and Year selector
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Month dropdown
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: goliathsTheme.stroke),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => DropdownButton<int>(
                        value: selectedDate.value.month,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: List.generate(12, (index) {
                          final month = index + 1;
                          return DropdownMenuItem(
                            value: month,
                            child: Text(
                              _getMonthName(month),
                              style: goliathsTypography.screenText,
                            ),
                          );
                        }),
                        onChanged: (month) {
                          if (month != null) {
                            selectedDate.value = DateTime(
                              selectedDate.value.year,
                              month,
                              selectedDate.value.day >
                                      DateTime(
                                        selectedDate.value.year,
                                        month + 1,
                                        0,
                                      ).day
                                  ? DateTime(
                                    selectedDate.value.year,
                                    month + 1,
                                    0,
                                  ).day
                                  : selectedDate.value.day,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Year dropdown
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: goliathsTheme.stroke),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => DropdownButton<int>(
                        value: selectedDate.value.year,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: List.generate(
                          lastDate.year - firstDate.year + 1,
                          (index) {
                            final year = lastDate.year - index;
                            return DropdownMenuItem(
                              value: year,
                              child: Text(
                                year.toString(),
                                style: goliathsTypography.screenText,
                              ),
                            );
                          },
                        ),
                        onChanged: (year) {
                          if (year != null) {
                            selectedDate.value = DateTime(
                              year,
                              selectedDate.value.month,
                              selectedDate.value.day,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(
              () => TableCalendar(
                firstDay: firstDate,
                lastDay: lastDate,
                focusedDay: selectedDate.value,
                selectedDayPredicate:
                    (day) => isSameDay(day, selectedDate.value),
                onDaySelected: (selected, focused) {
                  selectedDate.value = selected;
                },
                onPageChanged: (focusedDay) {
                  selectedDate.value = focusedDay;
                },
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                headerStyle: HeaderStyle(
                  titleTextStyle: goliathsTypography.screenTitle,
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: goliathsTheme.accent,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: goliathsTheme.accent,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: goliathsTheme.accent,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  defaultTextStyle: goliathsTypography.screenText,
                  weekendTextStyle: goliathsTypography.screenText,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Today's and Tomorrow's Birthdays Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today's Birthdays
                  Obx(() {
                    final todayBirthdays = _getTodayBirthdays();
                    if (todayBirthdays.isEmpty) return SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "🎉 Today's Birthdays",
                          style: goliathsTypography.screenTitle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ...todayBirthdays.map(
                          (birthday) => _buildBirthdayCard(birthday),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    );
                  }),
                  // Tomorrow's Birthdays
                  Obx(() {
                    final tomorrowBirthdays = _getTomorrowBirthdays();
                    if (tomorrowBirthdays.isEmpty) return SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "🎂 Tomorrow's Birthdays",
                          style: goliathsTypography.screenTitle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ...tomorrowBirthdays.map(
                          (birthday) => _buildBirthdayCard(birthday),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () =>
                dobController.isLoading.value
                    ? const CircularProgressIndicator()
                    : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.2.sw),
                      child: CustomElevatedButton(
                        text: "Next",
                        onPressed: () {
                          final dob = selectedDate.value;
                          final dobFormatted =
                              "${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}";
                          dobController.updateDateOfBirth(dobFormatted);
                        },
                        isFullWidth: true,
                      ),
                    ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  List<BirthdayItem> _getTodayBirthdays() {
    final today = DateTime.now();
    return birthdayController.allFriends.where((item) {
      final birthday = item.parsedDate;
      return birthday.month == today.month && birthday.day == today.day;
    }).toList();
  }

  List<BirthdayItem> _getTomorrowBirthdays() {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return birthdayController.allFriends.where((item) {
      final birthday = item.parsedDate;
      return birthday.month == tomorrow.month && birthday.day == tomorrow.day;
    }).toList();
  }

  Widget _buildBirthdayCard(BirthdayItem birthday) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: goliathsTheme.stroke),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage:
                birthday.image.isNotEmpty ? NetworkImage(birthday.image) : null,
            child:
                birthday.image.isEmpty ? Icon(Icons.person, size: 20.sp) : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  birthday.name,
                  style: goliathsTypography.screenText.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  birthday.formattedDate,
                  style: goliathsTypography.screenText.copyWith(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
