part of '../_pages.dart';

/// ****************************************************************************
/// Screen Chat (Ai Coach)
/// ****************************************************************************
class ScreenChat extends GetView<ControllerHome> {
  const ScreenChat({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments ?? {};
    final int? chatId = arguments['id'];
    final String chatTitle = arguments['title'] ?? "Ai";

    // Call API when the widget builds
    if (chatId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadChatMessages(chatId);
      });
    }

    return Scaffold(
      appBar: ChildPageAppBar(title: chatTitle),
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
                  separatorBuilder: (_, __) => 8.verticalSpace,
                ),
              ),
            ),
            ChatInputBox(
              onSendMessage: (message) async {
                if (chatId != null) {
                  await controller.sendMessageToChat(chatId, message);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
