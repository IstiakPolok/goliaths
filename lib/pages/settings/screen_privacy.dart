part of '../_pages.dart';

/// ****************************************************************************
/// "Privacy Policy page
/// ****************************************************************************
class ScreenPrivacyPolicy extends GetView<ControllerPrivacy> {
  const ScreenPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Privacy Policy"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Obx(
              () => Text(
                controller.privacy.value,
                style: goliathsTypography.screenText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
