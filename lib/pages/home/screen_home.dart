part of '../_pages.dart';

/// ****************************************************************************
/// Home Screen (Home Section Entry)
/// ****************************************************************************
class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final cardDecoration = BoxDecoration(
      color: Color(0xFF222222),
      borderRadius: BorderRadius.circular(26.r),
    );

    return Scaffold(
      appBar: HomeAppBar(title: "Good Morning, Susan", isButton: false,),
      bottomNavigationBar: BottomBar(selectedIndex: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Daily Motivation ================================================
            Text(
              "Daily Motivation",
              style: goliathsTypography.screenTitle.copyWith(fontSize: 16.sp),
              textAlign: TextAlign.start,
            ),
            12.verticalSpace,
            // You don't have to be great to start, but you have to start to be great.
            // – Zig Ziglar ====================================================
            Container(
              padding: EdgeInsets.all(32.r),
              decoration: cardDecoration.copyWith(
                image: DecorationImage(
                  image: AssetImage("assets/images/sky.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  "\"You don't have to be great to start, but you have to start to be great.\"\n– Zig Ziglar",
                  style: goliathsTypography.screenText.copyWith(
                    color: goliathsTheme.textOnPrimary,
                  ),
                ),
              ),
            ),
            16.verticalSpace,
            // How may I help you Today? =======================================
            Text(
              "How may I help you Today?",
              style: goliathsTypography.screenTitle.copyWith(fontSize: 16.sp),
              textAlign: TextAlign.start,
            ),
            12.verticalSpace,
            // Dashboard Card Section ==========================================
            AspectRatio(
              aspectRatio: 1.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Section ==============================================
                  Expanded(
                    flex: 60,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.birthDate),
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: cardDecoration,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Ai Icon
                            Start(
                              child: SvgPicture.asset(
                                "assets/icons/ai.svg",
                                height: 22.h,
                                width: 22.h,
                              ),
                            ),
                            // Bottom Section Of Cake
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Check your birthday!",
                                  style: goliathsTypography.screenText.copyWith(
                                    color: goliathsTheme.textOnPrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                6.verticalSpace,
                                Center(
                                  child: Image.asset(
                                    "assets/images/cake.png",
                                    width: 60.w,
                                    height: 40.h,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Right Section =============================================
                  Expanded(
                    flex: 38,
                    child: Column(
                      children: [
                        // Right Top Card
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.donationHome),
                            child: Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: cardDecoration.copyWith(
                                color: Color(0xFFB7B4B4),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Ai Icon
                                  Start(
                                    child: SvgPicture.asset(
                                      "assets/icons/doller_card.svg",
                                      height: 22.h,
                                      width: 22.h,
                                    ),
                                  ),
                                  // Bottom Section Of Cake
                                  Text(
                                    "Start\nDonation",
                                    style: goliathsTypography.screenText
                                        .copyWith(
                                          color: goliathsTheme.text,
                                          fontSize: 13.sp,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.w),
                        // Right Bottom Card
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.chat),
                            child: Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: cardDecoration.copyWith(
                                color: goliathsTheme.accent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Ai Icon
                                  Start(
                                    child: SvgPicture.asset(
                                      "assets/icons/chat_card.svg",
                                      height: 22.h,
                                      width: 22.h,
                                    ),
                                  ),
                                  // Bottom Section Of Cake
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Start\nnew chat",
                                        style: goliathsTypography.screenText
                                            .copyWith(
                                              color: goliathsTheme.text,
                                              fontSize: 13.sp,
                                            ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/arrow_right.svg",
                                        width: 18.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            // History Section =================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "History",
                  style: goliathsTypography.screenTitle.copyWith(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.start,
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.chatHistory);
                  },
                  child: Text(
                    "See All",
                    style: goliathsTypography.screenTitle.copyWith(
                      fontSize: 16.sp,
                      color: goliathsTheme.accent,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            // History Item
            ...[
              "How to Stay Focused?",
              "Felt more confident at work today!",
              "How to quit smoking?!",
            ].mapIndexed(
              (index, value) => HistoryItem(
                key: ValueKey(index),
                title: value,
                icon: SvgAssetLoader("assets/icons/history_${index + 1}.svg"),
                onClick: ()=> Get.toNamed(AppRoutes.chat),
              ),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
