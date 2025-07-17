part of '../_pages.dart';

/// ****************************************************************************
/// Terms and condition page
/// ****************************************************************************
class ScreenTermsCondition extends GetView<ControllerTerms> {
  const ScreenTermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Terms & Condition"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Obx(
              () => Text(
                controller.terms.value,
                style: goliathsTypography.screenText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
