part of '../_pages.dart';

/// ****************************************************************************
/// Verify email screen
/// ****************************************************************************
class ScreenVerifyEmail extends StatelessWidget {
  ScreenVerifyEmail({super.key});
  final controller = Get.put(VerifyEmailController());

  @override
  Widget build(BuildContext context) {
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
                  "Forgot Password?",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenTitle.copyWith(
                    color: goliathsTheme.textOnPrimary,
                    fontSize: 24.sp,
                  ),
                ),
                12.verticalSpace,
                Text(
                  "OTP will be sent to your email",
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
                CustomInputField(
                  hintText: "Email",
                  controller: controller.emailController,
                ),
                12.verticalSpace,
                Obx(
                  () => CustomElevatedButton(
                    text: controller.isLoading.value ? "Sending..." : "Submit",
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : controller.sendResetOtp,
                    isFullWidth: true,
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
