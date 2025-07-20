part of '../_pages.dart';

/// ****************************************************************************
/// Onboard Date Birth Pick Screen
/// ****************************************************************************
class ScreenDob extends GetView<ControllerOnboard> {
  ScreenDob({super.key});

  final DobController dobController = Get.put(DobController());
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final DateTime firstDate = DateTime(1900);
  final DateTime lastDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardAppBar(title: "What is your date of birth?"),
      body: Column(
        children: [
          const SizedBox(height: 60),
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
                headerStyle: HeaderStyle(
                  titleTextStyle: goliathsTypography.screenTitle,
                  formatButtonVisible: false,
                  titleCentered: true,
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
          const Spacer(),
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
        ],
      ),
    );
  }
}
