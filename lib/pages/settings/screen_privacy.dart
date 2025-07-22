part of '../_pages.dart';

/// ****************************************************************************
/// "Privacy Policy page
/// ****************************************************************************
class ScreenPrivacyPolicy extends StatelessWidget {
  const ScreenPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerPrivacy controller = Get.put(ControllerPrivacy());

    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.title.value,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Html(data: controller.content.value),
            ],
          ),
        );
      }),
    );
  }
}
