part of '../_pages.dart';

/// ****************************************************************************
/// Create/Reset password screen
/// ****************************************************************************
class ScreenCreatePassword extends StatelessWidget {
  final String email;
  const ScreenCreatePassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatePasswordController());
    controller.initEmail(email);
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
                CustomInputField(
                  hintText: "Password",
                  isPassword: true,
                  controller: controller.passwordController,
                ),
                12.verticalSpace,
                CustomInputField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  controller: controller.confirmPasswordController,
                  action: TextInputAction.done,
                ),
                12.verticalSpace,
                controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomElevatedButton(
                      text: "Submit",
                      onPressed: controller.resetPassword,
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
