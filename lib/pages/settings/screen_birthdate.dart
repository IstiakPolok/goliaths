part of '../_pages.dart';

/// ****************************************************************************
/// Screen for birthdate tracker
/// ****************************************************************************
class ScreenBirthdate extends StatelessWidget {
  const ScreenBirthdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Birthdate"),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hey Susan!",
                    style: goliathsTypography.screenTitle.copyWith(
                      color: goliathsTheme.accent,
                      fontSize: 22.sp,
                    ),
                  ),
                  CustomButtonSmall(text: "Add Birthday", onPressed: _showFriendAddBirth),
                ],
              ),
              24.verticalSpace,
              Center(child: ProgressCircle(days: 8, progress: 0.75)),
              24.verticalSpace,
              Text(
                "Your Birthday Remains 8 days",
                style: goliathsTypography.screenTitle.copyWith(
                  color: goliathsTheme.text,
                  fontSize: 26.sp,
                ),
              ),
              Text(
                "The best is yet to come. Keep shining, keep dreaming, and keep moving forward. You’re not just a year older—you’re a year better.",
                style: goliathsTypography.screenText.copyWith(
                  color: goliathsTheme.text,
                ),
              ),
              24.verticalSpace,
              _cardView(
                title: "Birthday Reminders",
                description: "Get notified about upcoming\nbirthdays",
                icon: SvgAssetLoader("assets/icons/calendar_large.svg"),
                onClick: () {
                  Get.toNamed(AppRoutes.friendsBirth);
                },
              ),
              12.verticalSpace,
              _cardView(
                title: "Wish suggestion",
                description: "Discover ideas for gift and\nmessage",
                icon: SvgAssetLoader("assets/icons/gift_large.svg"),
                onClick: () {
                  Get.toNamed(AppRoutes.birthWish);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFriendAddBirth(){
    Get.dialog(const ModalFriendBirthDate());
  }

  Widget _cardView({
    required String title,
    required String description,
    required SvgAssetLoader icon,
    required Function() onClick,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 26.r),
        decoration: BoxDecoration(
          border: Border.all(color: goliathsTheme.stroke, width: 2),
          borderRadius: BorderRadius.circular(26.r),
        ),
        child: Row(
          children: [
            SvgPicture(icon, height: 40.h, width: 40.h),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: goliathsTypography.screenText.copyWith(
                      color: goliathsTheme.text,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    description,
                    style: goliathsTypography.screenText.copyWith(
                      color: goliathsTheme.text.withValues(alpha: 0.8),
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
