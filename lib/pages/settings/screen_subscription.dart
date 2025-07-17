part of '../_pages.dart';

/// ****************************************************************************
/// Subscription Package List
/// ****************************************************************************
class ScreenSubscription extends GetView<ControllerSubscription> {
  const ScreenSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Upgrade to Premium"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Plan Card
            Card(
              color: goliathsTheme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: BorderSide(color: goliathsTheme.stroke, width: 1),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Basic Plan',
                          style: goliathsTypography.screenTitle.copyWith(
                            color: goliathsTheme.text,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          'Free',
                          style: goliathsTypography.screenTitle.copyWith(
                            color: goliathsTheme.text,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildFeatureItem(
                      'AI assistant helps with creating, organizing, and reminding you of tasks and deadlines',
                      color: goliathsTheme.primary,
                    ),
                    _buildFeatureItem(
                      'Provide quick answers to general knowledge questions and weather',
                      color: goliathsTheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Premium Plan Card
            Card(
              elevation: 30,
              shadowColor: goliathsTheme.primary.withValues(alpha: 0.2),
              color: goliathsTheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r),
                side: BorderSide(color: Colors.white24, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Premium Plan',
                          style: goliathsTypography.screenTitle.copyWith(
                            color: goliathsTheme.textOnPrimary,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          '\$10/month',
                          style: goliathsTypography.screenTitle.copyWith(
                            color: goliathsTheme.textOnPrimary,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Includes all features from the Basic and Standard Plans, plus:',
                      style: goliathsTypography.screenText.copyWith(
                        color: goliathsTheme.textOnPrimary.withValues(
                          alpha: 0.6,
                        ),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildFeatureItem(
                      'AI assistant helps with creating, organizing, and reminding you of tasks and deadlines',
                      color: goliathsTheme.textOnPrimary,
                    ),
                    _buildFeatureItem(
                      'Provide quick answers to general knowledge questions and weather',
                      color: goliathsTheme.textOnPrimary,
                    ),
                    SizedBox(height: 16.h),
                    Obx(
                      () => CustomElevatedButton(
                        backgroundColor:
                            controller.isActive.value
                                ? goliathsTheme.background
                                : goliathsTheme.accent,
                        text: controller.isActive.value ? "Activated" : "Buy",
                        onPressed: () {
                          if(controller.isActive.value){
                            showCancelSubscription();
                          }else {
                            controller.isActive.value = true;
                          }
                        },
                        isFullWidth: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCancelSubscription() {
    Get.dialog(
      CloseAbleDialog(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Do you want to cancel the subscription?",
                textAlign: TextAlign.start,
                style: goliathsTypography.screenText,
              ),
              12.verticalSpace,
              CustomElevatedButton(
                text: "Cancel",
                onPressed: () {
                  controller.isActive.value = false;
                  Get.close(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/check.svg",
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            height: 20.r,
            width: 20.r,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: goliathsTypography.screenText.copyWith(
                color: color,
                fontFamily: "Roboto",
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
