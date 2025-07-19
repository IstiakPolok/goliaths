part of '../_pages.dart';

/// ****************************************************************************
/// Screen for choose ai type
/// ****************************************************************************
class ScreenAiType extends StatelessWidget {
  ScreenAiType({super.key});
  final AiTypeController controller = Get.put(AiTypeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: goliathsTheme.primary, // Dark background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 68,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ThreeDotSvg()],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // Assistant details =================================================
                    Text(
                      "Choose Your AI\nAssistant as",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontFamily: "Poly",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    // Friend Button  ====================================================
                    CustomElevatedButton(
                      text: "Friend",
                      onPressed: () {
                        controller.selectMode("friend");
                        Get.toNamed(AppRoutes.country);
                      },
                      isFullWidth: true,
                    ),
                    12.verticalSpace,
                    CustomElevatedButton(
                      text: "Coach",
                      onPressed: () {
                        controller.selectMode("coach");
                        Get.toNamed(AppRoutes.country);
                      },
                      isFullWidth: true,
                    ),

                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
