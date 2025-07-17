part of '../_pages.dart';

/// ****************************************************************************
/// Screen of history
/// ****************************************************************************
class ScreenHistory extends GetView<ControllerHistory> {
  const ScreenHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "History"),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          itemBuilder: (context, index) {
            return HistoryItem(
              key: ValueKey(index),
              title: controller.history[index],
              icon: SvgAssetLoader(
                "assets/icons/history_${Random().nextInt(2) + 1}.svg",
              ),
              onClick: ()=> Get.toNamed(AppRoutes.chat),
            );
          },
          itemCount: controller.history.length,
        ),
      ),
    );
  }
}
