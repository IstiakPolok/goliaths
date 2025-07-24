part of '../_pages.dart';

/// ****************************************************************************
/// Screen of history
/// ****************************************************************************
class ScreenHistory extends GetView<ControllerHistory> {
  const ScreenHistory({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchHistory(); // ⬅️ Triggers history refresh
    });
    return Scaffold(
      appBar: ChildPageAppBar(title: "History"),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.historyList.isEmpty) {
            return const Center(child: Text("No history found."));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            itemCount: controller.historyList.length,
            itemBuilder: (context, index) {
              final item = controller.historyList[index];
              final displayTitle =
                  item.title?.isNotEmpty == true
                      ? item.title!
                      : item.mode?.isNotEmpty == true
                      ? item.mode!
                      : "Untitled";

              return HistoryItem(
                key: ValueKey(item.id),
                title: displayTitle,
                icon: SvgAssetLoader(
                  "assets/icons/history_${(index % 2) + 1}.svg",
                ),
                onClick:
                    () => Get.toNamed(
                      AppRoutes.chat,
                      arguments: {'id': item.id, 'title': displayTitle},
                    ),
              );
            },
          );
        }),
      ),
    );
  }
}
