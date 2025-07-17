part of '../_pages.dart';

/// ****************************************************************************
/// Onboard Date Birth Pick Screen
/// ****************************************************************************
class ScreenDob extends GetView<ControllerOnboard> {
  const ScreenDob({super.key});

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
                yearAndMonthHeaderTextStyle:
                goliathsTypography.screenTitle,
                unselectedDayTextStyle: goliathsTypography.screenText,
              ),
            ),
          ),
          Spacer(),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.2.sw),
                child: CustomElevatedButton(
                  text: "Next",
                  onPressed: () {
                    Get.toNamed(AppRoutes.home);
                  },
                  isFullWidth: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
