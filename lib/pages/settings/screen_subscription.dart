part of '../_pages.dart';

/// ****************************************************************************
/// Subscription Package List
/// ****************************************************************************
class ScreenSubscription extends GetView<ControllerSubscription> {
  const ScreenSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Upgrade to Premium"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Plan Card (Static as per your original code)
            // Card(
            //   color: goliathsTheme.background,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(22),
            //     side: BorderSide(color: goliathsTheme.stroke, width: 1),
            //   ),
            //   elevation: 0,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Basic Plan',
            //               style: goliathsTypography.screenTitle.copyWith(
            //                 color: goliathsTheme.text,
            //                 fontSize: 18.sp,
            //               ),
            //             ),
            //             Text(
            //               'Free',
            //               style: goliathsTypography.screenTitle.copyWith(
            //                 color: goliathsTheme.text,
            //                 fontSize: 18.sp,
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 16),
            //         _buildFeatureItem(
            //           'AI assistant helps with creating, organizing, and reminding you of tasks and deadlines',
            //           color: goliathsTheme.primary,
            //         ),
            //         _buildFeatureItem(
            //           'Provide quick answers to general knowledge questions and weather',
            //           color: goliathsTheme.primary,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),
            // Observe the plans list from the controller
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.plans.isEmpty) {
                return const Center(
                  child: Text("No premium plans available at the moment."),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.plans.length,
                    itemBuilder: (context, index) {
                      final plan = controller.plans[index];
                      // Assuming 'name', 'price', and 'features' are keys in your plan map
                      final String planName = plan['name'] ?? 'Unknown Plan';
                      final String planPrice =
                          plan['price'] != null
                              ? '\$${plan['price'].toString()}/month'
                              : 'Price TBD';
                      final List<dynamic> planFeatures =
                          plan['features'] ??
                          []; // Assuming features is a list of strings

                      // You can customize the look of each dynamic plan card here
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                        ), // Spacing between cards
                        child: Card(
                          elevation: 30,
                          shadowColor: goliathsTheme.primary.withValues(
                            alpha: 0.2,
                          ),
                          color: goliathsTheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.r),
                            side: BorderSide(color: Colors.white24, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      planName,
                                      style: goliathsTypography.screenTitle
                                          .copyWith(
                                            color: goliathsTheme.textOnPrimary,
                                            fontSize: 18.sp,
                                          ),
                                    ),
                                    Text(
                                      planPrice,
                                      style: goliathsTypography.screenTitle
                                          .copyWith(
                                            color: goliathsTheme.textOnPrimary,
                                            fontSize: 18.sp,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  // This text can be dynamic based on your API response or a default for premium
                                  'Includes all features from the Basic Plan, plus:',
                                  style: goliathsTypography.screenText.copyWith(
                                    color: goliathsTheme.textOnPrimary
                                        .withValues(alpha: 0.6),
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                // Dynamically build feature items
                                ...planFeatures.map((featureText) {
                                  // Check if featureText is Map and has 'description'
                                  String cleanedText = '';
                                  if (featureText is Map && featureText.containsKey('description')) {
                                    cleanedText = featureText['description'] ?? '';
                                  } else {
                                    cleanedText = featureText.toString();
                                  }

                                  return _buildFeatureItem(
                                    cleanedText,
                                    color: goliathsTheme.textOnPrimary,
                                  );
                                }).toList(),



                                SizedBox(height: 16.h),
                                Obx(() {
                                  final isCurrentPlan =
                                      controller.currentSubscribedPlanId.value == plan['id'];

                                  return CustomElevatedButton(
                                    backgroundColor: isCurrentPlan
                                        ? goliathsTheme.background
                                        : goliathsTheme.accent,
                                    text: isCurrentPlan ? "Activated" : "Buy",
                                    onPressed: () async {
                                      if (isCurrentPlan) {
                                        //showCancelSubscription();
                                      } else {
                                        await controller.createCheckoutSession(plan);
                                      }
                                    },
                                    isFullWidth: true,
                                  );
                                }),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  void showCancelSubscription() {
    Get.dialog(
      CloseAbleDialog(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Do you want to cancel the subscription?",
                textAlign: TextAlign.start,
                style: goliathsTypography.screenText,
              ),
              12.verticalSpace,
              CustomElevatedButton(
                text: "Cancel",
                onPressed: () {
                  controller.isActive.value = false;
                  Get.close(1);
                  Get.snackbar("Success", "Subscription cancelled.");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/check.svg",
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            height: 20.r,
            width: 20.r,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: goliathsTypography.screenText.copyWith(
                color: color,
                fontFamily: "Roboto",
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
