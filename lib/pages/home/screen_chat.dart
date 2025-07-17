part of '../_pages.dart';

/// ****************************************************************************
/// Screen Chat (Ai Coach)
/// ****************************************************************************
class ScreenChat extends GetView<ControllerHome> {
  const ScreenChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Ai Coach"),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
                  itemCount: controller.chatMessages.length,
                  itemBuilder: (context, index) {
                    final item = controller.chatMessages[index];
                    return ChatItemView(
                      text: item.text,
                      role: item.role,
                      chatPosition: item.chatPosition,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 8.verticalSpace;
                  },
                ),
              ),
            ),
            ChatInputBox(onSendMessage: (_) {}),
          ],
        ),
      ),
    );
  }
}
