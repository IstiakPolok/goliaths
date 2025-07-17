part of '../_pages.dart';

class ScreenAvatarList extends GetView<ControllerOnboard> {
  const ScreenAvatarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: goliathsTheme.primary,
      // Set background color using primary color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Page indicators to show the current page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.totalPages,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: 24,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color:
                          index == controller.currentPage.value - 1
                              ? goliathsTheme.accent // Gold color for the current page
                              : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title section
              Text(
                'Choose Your Ai Assistant',
                textAlign: TextAlign.center,
                style: goliathsTypography.screenHeading,
              ),
              const SizedBox(height: 40),

              // Grid of assistants, using expanded to fill available space
              // Grid of assistants using Row and Column
              Column(
                children: [
                  // First row with two items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _buildAssistantCard(0)), // First assistant
                      const SizedBox(width: 16), // Row space
                      Expanded(child: _buildAssistantCard(1)), // Second assistant
                    ],
                  ),
                  const SizedBox(height: 16), // Space between rows
                  // Second row with two items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _buildAssistantCard(2)), // Third assistant
                      const SizedBox(width: 16), // Row space
                      Expanded(child: _buildAssistantCard(3)), // Fourth assistant
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildAssistantCard(int index) {
    return GestureDetector(
      onTap: () {
        controller.selectAssistant(index);
        Get.toNamed(AppRoutes.avatarDetail);
      },
      child: InkWell(
        onTap: () {
          controller.selectAssistant(index);
          Get.toNamed(AppRoutes.avatarDetail);
        },
        splashColor: goliathsTheme.accent.withValues(alpha: 0.3),
        highlightColor: goliathsTheme.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            controller.assistants[index]['image']!,
            fit: BoxFit.contain,
            height: 0.3.sh,
          ),
        ),
      ),
    );
  }
}
