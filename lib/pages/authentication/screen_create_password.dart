part of '../_pages.dart';

/// ****************************************************************************
/// Create/Reset password screen
/// ****************************************************************************
class ScreenCreatePassword extends StatelessWidget {
  const ScreenCreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "New password",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenTitle.copyWith(
                    color: goliathsTheme.textOnPrimary,
                    fontSize: 24.sp,
                  ),
                ),
                12.verticalSpace,
                Text(
                  "Create a new password for login",
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
                CustomInputField(hintText: "Password", isPassword: true),
                12.verticalSpace,
                CustomInputField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  action: TextInputAction.done,
                ),
                12.verticalSpace,
                CustomElevatedButton(
                  text: "Submit",
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login);
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
