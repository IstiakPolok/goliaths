part of '../_pages.dart';

/// ****************************************************************************
/// Verify otp screen
/// ****************************************************************************
class ScreenResetVerifyOtp extends StatelessWidget {
  const ScreenResetVerifyOtp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    final String email = Get.arguments["email"];

    controller.userEmail.value = email; // Pass it to controller if needed

    return AuthScaffold(
      appBar: ChildPageAppBar(
        background: Colors.transparent,
        color: goliathsTheme.textOnPrimary.withValues(alpha: 0.8),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Verify OTP",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenTitle.copyWith(
                    color: goliathsTheme.textOnPrimary,
                    fontSize: 24.sp,
                  ),
                ),
                12.verticalSpace,
                Text(
                  "OTP sent to your email",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenText.copyWith(
                    color: goliathsTheme.textOnPrimary,
                    fontFamily: "Roboto",
                  ),
                ),
              ],
            ),
            Column(
              children: [
                36.verticalSpace,
                InputOtpFields(
                  onOtpChange: (value) {
                    controller.otpController.text = value;
                  },
                ),
                12.verticalSpace,
                Obx(
                  () => CustomElevatedButton(
                    text: "Submit",
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () => controller.submitOtp(),
                    isFullWidth: true,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ],
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
