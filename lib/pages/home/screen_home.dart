part of '../_pages.dart';

/// ****************************************************************************
/// Home Screen (Home Section Entry)
/// ****************************************************************************
class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final List<String> dailyQuotes = [
    "You were not created to struggle endlessly; peace is part of your design.",
    "With every difficulty, there is the seed of ease — maybe more than once.",
    "You are never alone in your pain — there is always someone listening, even in silence.",
    "Patience is not just waiting — it is strength wrapped in calm.",
    "Even when the world feels heavy, you are still guided gently toward light.",
    "No soul is ever burdened with more than it can carry.",
    "Your journey has meaning — even the slow days are shaping something beautiful.",
    "Healing may take time, but no pain is permanent.",
    "The night may feel long, but morning always arrives.",
    "There is value in every small act of goodness — especially the ones you give yourself.",
    "Your struggles don’t define you — how you rise through them does.",
    "Peace starts inside — even if the world is loud.",
    "You are more resilient than your thoughts tell you.",
    "It’s brave to slow down and breathe when your mind wants to run.",
    "You deserve gentleness — especially from yourself.",
    "You can restart at any moment. You don’t need permission.",
    "Quiet victories matter too — getting up, showing up, and trying again.",
    "Your emotions are visitors. Let them come, feel them, and let them go.",
    "You don’t have to do everything today. Healing is not a race.",
    "Even if no one sees your effort, it still counts.",
    "Let your heart rest. You are not behind in life.",
    "When it’s dark, even the smallest light becomes powerful.",
    "You are still growing, even in stillness.",
    "Be soft with your past. You did the best you could.",
    "You are not broken — you are becoming.",
    "It’s not weakness to rest — it’s how strength is rebuilt.",
    "There’s wisdom in the pauses. Don’t rush the process.",
    "You’ve made it through so much. This moment will pass too.",
    "Not every thought deserves your attention.",
    "Your peace is more important than perfection.",
  ];


  String getTodayQuote() {
    final today = DateTime.now();
    // Use day of year or just day of month for simplicity
    final index = today.day % dailyQuotes.length; // cycles through quotes each day
    return dailyQuotes[index];
  }
  late final ProfileController profilecontroller;
  late final ControllerHistory historyController;

  @override
  void initState() {
    super.initState();
    profilecontroller = Get.put(ProfileController());
    profilecontroller.fetchProfile();


    historyController = Get.put(ControllerHistory());
    historyController.fetchHistory(); // ✅ Up-to-date list
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    historyController.fetchHistory(); // ✅ Refresh when screen is re-displayed
  }




  Widget build(BuildContext context) {


    final historyController = Get.put(ControllerHistory());
    final controllerHome = Get.put(ControllerHome());
    final profilecontroller = Get.put(ProfileController());
    final cardDecoration = BoxDecoration(
      color: Color(0xFF222222),
      borderRadius: BorderRadius.circular(26.r),
    );



    return Scaffold(
      appBar: HomeAppBar(

      ),

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
                  getTodayQuote(),
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
                        Expanded(
                          child: Container(
                            decoration: cardDecoration.copyWith(
                              color: const Color(0xFFB7B4B4),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/dummy.jpg"), // ← Your background image
                                fit: BoxFit.cover, // Makes the image fill the entire container
                              ),
                            ),
                            padding: EdgeInsets.all(16.r),
                            // Optional child here if needed, or leave empty for just image background
                            child: null, // ← Replace with widgets if you want to overlay content
                          ),
                        ),


                        // Right Top Card
                        // Expanded(
                        //   child: GestureDetector(
                        //     onTap: () => Get.toNamed(AppRoutes.donationAmount),
                        //     child: Container(
                        //       padding: EdgeInsets.all(16.r),
                        //       decoration: cardDecoration.copyWith(
                        //         color: Color(0xFFB7B4B4),
                        //       ),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.stretch,
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           // Ai Icon
                        //           Start(
                        //             child: SvgPicture.asset(
                        //               "assets/icons/doller_card.svg",
                        //               height: 22.h,
                        //               width: 22.h,
                        //             ),
                        //           ),
                        //           // Bottom Section Of Cake
                        //           Text(
                        //             "Start\nDonation",
                        //             style: goliathsTypography.screenText
                        //                 .copyWith(
                        //                   color: goliathsTheme.text,
                        //                   fontSize: 13.sp,
                        //                 ),
                        //             textAlign: TextAlign.start,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 12.w),
                        // Right Bottom Card
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controllerHome.selectModeAndStartChat();
                            },

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
                  onTap: () {
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
            Obx(() {
              final items = historyController.historyList.take(3).toList();
              if (items.isEmpty) {
                return const Text("No history yet.");
              }

              return Column(
                children: items.mapIndexed((index, item) {
                  final title = item.title?.isNotEmpty == true
                      ? item.title!
                      : item.mode?.isNotEmpty == true
                      ? item.mode!
                      : "Untitled";

                  return HistoryItem(
                    key: ValueKey(item.id),
                    title: title,
                    icon: SvgAssetLoader(
                      "assets/icons/history_${(index % 2) + 1}.svg",
                    ),
                    onClick: () => Get.toNamed(
                      AppRoutes.chat,
                      arguments: {'id': item.id, 'title': title},
                    ),
                  );
                }).toList(),
              );
            }),


            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
