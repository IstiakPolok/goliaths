part of '../_pages.dart';

/// ****************************************************************************
/// Single Avatar PageView Indicator
/// ****************************************************************************
class ScreenAvatarDetail extends GetView<ControllerOnboard> {
  const ScreenAvatarDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: goliathsTheme.primary, // Dark background
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 68,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Arrow Button =========================================
                  Obx(
                    () => GestureDetector(
                      onTap:
                          controller.currentPage.value > 0
                              ? controller.previousPage
                              : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              controller.currentPage.value > 0
                                  ? goliathsTheme.accent
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Visibility(
                          visible: controller.currentPage.value > 0,
                          child: Icon(
                            Icons.arrow_back,
                            color: goliathsTheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Center Indicator ==========================================
                  Expanded(
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.totalPages,
                          (i) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: 24,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color:
                                  i == controller.currentPage.value
                                      ? goliathsTheme
                                          .accent // Gold/yellow for current page
                                      : i < controller.currentPage.value
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Right side button =========================================
                  Obx(
                    () => GestureDetector(
                      onTap:
                          controller.currentPage.value <
                                  controller.totalPages - 1
                              ? controller.nextPage
                              : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              controller.currentPage.value <
                                      controller.totalPages - 1
                                  ? goliathsTheme.accent
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Visibility(
                          visible:
                              controller.currentPage.value <
                              controller.totalPages - 1,
                          child: Icon(
                            Icons.arrow_forward,
                            color: goliathsTheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: controller.totalPages,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                controller:controller.pageViewController,
                itemBuilder: (context, index) {
                  return _buildAssistantPage(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Page Section Builder Function =============================================
  Widget _buildAssistantPage(int index) {
    final assistant = controller.assistants[index];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20), // Space for the top navigation
          // Assistant image
          Expanded(
            child: Center(
              child: Image.asset(assistant['image'], fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 20),
          // Assistant details =================================================
          Text(
            assistant['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: "Poly"
            ),
          ),
          const SizedBox(height: 80),
          // Choose Button  ====================================================
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.aiType),
            child: Container(
              width: double.infinity,
              height: 56,
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: goliathsTheme.accent,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Center(
                child: Text(
                  'Choose',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
