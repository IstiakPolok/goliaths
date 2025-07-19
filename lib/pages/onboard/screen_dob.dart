part of '../_pages.dart';

/// ****************************************************************************
/// Onboard Date Birth Pick Screen
/// ****************************************************************************
class ScreenDob extends GetView<ControllerOnboard> {
  ScreenDob({super.key});

  final DobController dobController = Get.put(DobController());
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardAppBar(title: "What is your date of birth?"),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AwesomeCalenDart(
              elevation: 0,
              theme: AwesomeTheme(
                selectedDateBackgroundColor: goliathsTheme.accent,
                yearAndMonthHeaderTextStyle: goliathsTypography.screenTitle,
                unselectedDayTextStyle: goliathsTypography.screenText,
              ),
            ),
          ),
          Spacer(),
          Obx(
            () =>
                dobController.isLoading.value
                    ? const CircularProgressIndicator()
                    : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.2.sw),
                      child: CustomElevatedButton(
                        text: "Next",
                        onPressed: () {
                          final dobFormatted =
                              "${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}";
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
