part of '../_pages.dart';

/// ****************************************************************************
/// Login screen
/// ****************************************************************************
class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return AuthScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Title and text section ==========================================
            Column(
              children: [
                Text(
                  "Let Get Started",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenTitle.copyWith(
                    color: goliathsTheme.textOnPrimary,
                    fontSize: 24.sp,
                  ),
                ),
                36.verticalSpace,
                Text(
                  "We are the best solution for your daily life",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenText.copyWith(
                    color: goliathsTheme.textOnPrimary,
                  ),
                ),
                Text(
                  "If you don’t have an account register",
                  textAlign: TextAlign.center,
                  style: goliathsTypography.screenText.copyWith(
                    color: goliathsTheme.textOnPrimary,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  // Centers the text
                  text: TextSpan(
                    style: goliathsTypography.screenText.copyWith(
                      color: goliathsTheme.textOnPrimary,
                    ),
                    children: [
                      const TextSpan(text: 'You can '),
                      TextSpan(
                        text: 'Register here!',
                        style: goliathsTypography.screenText.copyWith(
                          color: goliathsTheme.accent,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(AppRoutes.register);
                              },
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
                  hintText: "Email",
                  controller: controller.emailController,
                ),
                12.verticalSpace,
                CustomInputField(
                  hintText: "Password",
                  isPassword: true,
                  action: TextInputAction.done,
                  controller: controller.passwordController,
                ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Forgot password Button ==================================
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.verifyEmail);
                      },
                      child: Text(
                        "Forgot password?",
                        style: goliathsTypography.screenText.copyWith(
                          color: goliathsTheme.textOnPrimary.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
              ],
            ),
            // Submit/Login Button =============================================
            Obx(() => CustomElevatedButton(
              text: "Login",
              onPressed: controller.loginUser,
              isFullWidth: true,
              isLoading: controller.isLoading.value,
            )),

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
            //       // Google/Social login ==========================
            //       child: GestureDetector(
            //         onTap: () {},
            //         child: SvgPicture.asset(
            //           "assets/icons/google.svg",
            //           height: 32.h,
            //           width: 32.h,
            //         ),
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
