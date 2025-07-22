part of '../_pages.dart';

/// ****************************************************************************
/// Terms and condition page
/// ****************************************************************************
class ScreenTermsCondition extends StatelessWidget {
  const ScreenTermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerTerms controller = Get.put(ControllerTerms());

    return Scaffold(
      appBar: ChildPageAppBar(title: "Terms & Condition"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.title.value,
                style: goliathsTypography.screenText,
              ),
              const SizedBox(height: 16),
              Html(data: controller.terms.value),
            ],
          ),
        );
      }),
    );
  }
}
