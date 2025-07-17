part of '../_pages.dart';

/// ****************************************************************************
/// Register screen
/// ****************************************************************************
class ScreenRegister extends StatelessWidget {
  ScreenRegister({super.key});
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Title & description =============================================
            Column(
              children: [
                Text(
                  "Create new account",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenTitle.copyWith(
                    color: goliathsTheme.textOnPrimary,
                    fontSize: 24.sp,
                  ),
                ),
                36.verticalSpace,
                Text(
                  "If you already have an account registered",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenText.copyWith(
                    color: goliathsTheme.textOnPrimary,
                    fontFamily: "Roboto",
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  // Centers the text
                  text: TextSpan(
                    style: goliathsTypography.screenText.copyWith(
                      color: goliathsTheme.textOnPrimary,
                      fontFamily: "Roboto",
                    ),
                    children: [
                      const TextSpan(text: 'You can '),
                      TextSpan(
                        text: 'Login here!',
                        style: goliathsTypography.screenText.copyWith(
                          color: goliathsTheme.accent,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Form fields =====================================================
            Column(
              children: [
                36.verticalSpace,
                CustomInputField(
                  hintText: "Full Name",
                  controller: controller.fullNameController,
                ),
                12.verticalSpace,
                CustomInputField(
                  hintText: "Email",
                  controller: controller.emailController,
                ),
                12.verticalSpace,
                CustomInputField(
                  hintText: "Password",
                  isPassword: true,
                  controller: controller.passwordController,
                ),
                12.verticalSpace,
                CustomInputField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  action: TextInputAction.done,
                  controller: controller.confirmPasswordController,
                ),
                12.verticalSpace,
              ],
            ),
            Obx(() {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomElevatedButton(
                    text: "Register",
                    onPressed: controller.registerUser,
                    isFullWidth: true,
                  );
            }),
            // Column(
            //   children: [
            //     24.verticalSpace,
            //     Text(
            //       "or continue with",
            //       style: goliathsTypography.screenText.copyWith(
            //         color: goliathsTheme.textOnPrimary.withValues(alpha: 0.7),
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //     12.verticalSpace,
            //     Center(
            //       child: SvgPicture.asset(
            //         "assets/icons/google.svg",
            //         height: 32.h,
            //         width: 32.h,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
