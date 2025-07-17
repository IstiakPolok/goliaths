part of '../_pages.dart';

/// ****************************************************************************
/// Choice authentication either login or register
/// ****************************************************************************
class ScreenAuthEntry extends StatefulWidget {
  const ScreenAuthEntry({super.key});

  @override
  State<ScreenAuthEntry> createState() => _ScreenAuthEntryState();
}

class _ScreenAuthEntryState extends State<ScreenAuthEntry> {
  @override
  void initState() {
    super.initState();
    showLightStatusIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // Background Image ==================================================
          image: DecorationImage(
            image: AssetImage('assets/images/auth_entry_bg.jpg'),
            // your background image
            fit: BoxFit.cover,
            alignment: Alignment(-0.5, 0.0),
          ),
        ),
        // main body content ===================================================
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xDB353131),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.r),
                    topRight: Radius.circular(36.r),
                  ),
                ),
                padding: EdgeInsets.all(32.r),
                child: Column(
                  // Title and text section
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: goliathsTypography.screenText.copyWith(
                          fontSize: 28.sp,
                          height: 1.1,
                        ),
                        children: [
                          TextSpan(
                            text: "Welcome\nTo\n",
                            style: TextStyle(
                              color: goliathsTheme.textOnPrimary,
                            ),
                          ),
                          TextSpan(
                            text: "Breaking Goliaths",
                            style: TextStyle(
                              color: goliathsTheme.accent,
                              height: 1.0,
                              fontFamily: "Rakkas",
                            ),
                          ),
                        ],
                      ),
                    ),

                    6.verticalSpace,
                    Text(
                      "We are the best solution for your daily life and best solution for your daily life",
                      style: goliathsTypography.screenText.copyWith(
                        color: goliathsTheme.textOnPrimary.withValues(
                          alpha: 0.8,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    24.verticalSpace,
                    ThreeDotSvg(),
                    24.verticalSpace,
                    Row(
                      // Buttons Login / Register
                      children: [
                        12.horizontalSpace,
                        // CTA Button ==========================================
                        Expanded(
                          child: CustomElevatedButton(
                            text: "Register",
                            onPressed: () {
                              Get.offNamed(AppRoutes.register);
                            },
                            backgroundColor: goliathsTheme.background,
                          ),
                        ),
                        12.horizontalSpace,
                        // CTA Button ==========================================
                        Expanded(
                          child: CustomElevatedButton(
                            text: "Login",
                            onPressed: () {
                              Get.offNamed(AppRoutes.login);
                            },
                          ),
                        ),
                        12.horizontalSpace,
                      ],
                    ),
                    24.verticalSpace,
                    // Terms and Privacy =======================================
                    TermsAndPrivacyText(privacyClick: () {
                      Get.toNamed(AppRoutes.privacy);
                    }, termClick: () {
                      Get.toNamed(AppRoutes.terms);
                    }),
                  ],
                ),
              ),
            ],
          ), // All your content here
        ),
      ),
    );
  }
}
