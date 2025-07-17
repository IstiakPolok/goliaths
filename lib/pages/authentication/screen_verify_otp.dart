part of '../_pages.dart';

/// ****************************************************************************
/// Verify otp screen
/// ****************************************************************************
class ScreenVerifyOtp extends StatelessWidget {
  const ScreenVerifyOtp({super.key});

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
                InputOtpFields(onOtpChange: (otp) {}),
                12.verticalSpace,
                CustomElevatedButton(
                  text: "Submit",
                  onPressed: () {
                    Get.toNamed(AppRoutes.createPass);
                  },
                  isFullWidth: true,
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
