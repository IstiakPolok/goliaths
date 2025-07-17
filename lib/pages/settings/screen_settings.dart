part of '../_pages.dart';

/// ****************************************************************************
/// Setting Screen
/// ****************************************************************************
class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Settings"),
      bottomNavigationBar: BottomBar(selectedIndex: 2),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Account",
              style: goliathsTypography.screenText.copyWith(
                color: Color(0xFF6E6E6E),
              ),
              textAlign: TextAlign.start,
            ),
            SettingTile(
              icon: SvgAssetLoader("assets/icons/user_profile.svg"),
              title: "User Profile",
              onTap: () {
                Get.toNamed(AppRoutes.profile);
              },
            ),
            SettingTile(
              icon: SvgAssetLoader("assets/icons/premium.svg"),
              title: "Upgrade to Premium",
              onTap: () {
                Get.toNamed(AppRoutes.subscription);
              },
            ),
            SettingTile(
              icon: SvgAssetLoader("assets/icons/privacy.svg"),
              title: "Privacy Policy",
              onTap: () {
                Get.toNamed(AppRoutes.privacy);
              },
            ),
            SettingTile(
              icon: SvgAssetLoader("assets/icons/terms.svg"),
              title: "Terms & Condition",
              onTap: () {
                Get.toNamed(AppRoutes.terms);
              },
            ),
            SettingTile(
              icon: SvgAssetLoader("assets/icons/help.svg"),
              title: "Help Support",
              onTap: () {
                Get.toNamed(AppRoutes.faq);
              },
            ),
            36.verticalSpace,
            SettingTile(
              icon: SvgAssetLoader("assets/icons/logout.svg"),
              title: "Logout",
              onTap: () {
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
