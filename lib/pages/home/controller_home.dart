part of '../_pages.dart';

/// ****************************************************************************
/// Controller for home section
/// ****************************************************************************
class ControllerHome extends GetxController {
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;

  Future<void> loadChatMessages(int chatId) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      if (kDebugMode) {
        print("📌 Access Token: $token");
      }

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/conversations/$chatId/messages/"),

        headers: {
          "Authorization": "JWT $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        chatMessages.value =
            data.map((item) {
              return ChatMessage(
                text: item["content"] ?? "",
                role: item["role"] == "user" ? ChatRole.user : ChatRole.ai,
                chatPosition: ChatPosition.single,
              );
            }).toList();
      } else {
        if (kDebugMode) {
          print(
            "❌ Failed to load messages: ${response.statusCode} ${response.body}",
          );
        }
        Get.snackbar("Error", "Failed to load chat messages");
      }
    } catch (e) {
      if (kDebugMode) {
        print("🔥 Exception occurred: $e");
      }
      Get.snackbar("Error", "Something went wrong");
    }
  }

  var isLoading = false.obs;

  Future<void> selectModeAndStartChat() async {
    try {
      isLoading.value = true;

      // Get mode from SharedPreferences
      final String? mode = await SharedPreferencesHelper.getSelectedAiMode();
      if (mode == null || mode.isEmpty) {
        Get.snackbar("Error", "No AI mode selected.");
        isLoading.value = false;
        return;
      }

      final token = await SharedPreferencesHelper.getAccessToken();
      final url = Uri.parse("${Urls.baseUrl}/conversations/select_mode/");

      final response = await http.post(
        url,
        headers: {
          "Authorization": "JWT $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"mode": mode}),
      );

      if (kDebugMode) {
        print("💬 select_mode response: ${response.body}");
      }

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final int conversationId = data["conversation_id"];
        final String title = mode.capitalizeFirst ?? "Ai";

        // Navigate to chat screen with arguments
        Get.toNamed(
          AppRoutes.chat,
          arguments: {"id": conversationId, "title": title},
        );
      } else {
        Get.snackbar("Error", "Failed to start a new chat.");
      }
    } catch (e) {
      if (kDebugMode) print("❌ select_mode error: $e");
      Get.snackbar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  //   Future<void> sendMessageToChat(int chatId, String userMessage) async {
  //   try {
  //     // 1. Immediately show the user message
  //     chatMessages.add(
  //       ChatMessage(
  //         text: userMessage,
  //         role: ChatRole.user,
  //         chatPosition: ChatPosition.single,
  //       ),
  //     );

  //     final token = await SharedPreferencesHelper.getAccessToken();
  //     final url = Uri.parse(
  //       "${Urls.baseUrl}/conversations/$chatId/send_message/",
  //     );

  //     final response = await http.post(
  //       url,
  //       headers: {
  //         "Authorization": "JWT $token",
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({"title": userMessage}),
  //     );

  //     if (kDebugMode) {
  //       print("✅ Sent: $userMessage");
  //       print("🧠 API Response: ${response.body}");
  //     }

  //     if (response.statusCode == 200) {
  //       // Optional: add AI response right away
  //       final data = jsonDecode(response.body);

  //       chatMessages.add(
  //         ChatMessage(
  //           text: data["AI"] ?? "No response",
  //           role: ChatRole.ai,
  //           chatPosition: ChatPosition.single,
  //         ),
  //       );

  //       // Wait for 2 seconds, then refresh from server
  //       await Future.delayed(const Duration(seconds: 1));
  //       await loadChatMessages(chatId);
  //     } else {
  //       Get.snackbar("Error", "Message failed to send.");
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("❌ sendMessage error: $e");
  //     }
  //     Get.snackbar("Error", "Something went wrong.");
  //   }
  // }  1227   4242424242424242



  Future<void> sendMessageToChat(int chatId, String userMessage) async {
    try {
      // Add user message
      final userMsg = ChatMessage(
        text: userMessage,
        role: ChatRole.user,
        chatPosition: ChatPosition.single,
      );
      chatMessages.add(userMsg);

      // Add temporary AI loader
      final aiLoaderMsg = ChatMessage(
        text: ".",
        role: ChatRole.ai,
        chatPosition: ChatPosition.single,
      );
      chatMessages.add(aiLoaderMsg);

      // Start animated dot loader in a separate async loop
      bool keepLoading = true;
      int dotCount = 1;

      Future loader = Future(() async {
        while (keepLoading) {
          aiLoaderMsg.text = "." * dotCount;
          dotCount = dotCount == 3 ? 1 : dotCount + 1;
          chatMessages.refresh();
          await Future.delayed(const Duration(milliseconds: 400));
        }
      });

      // Send request to API
      final token = await SharedPreferencesHelper.getAccessToken();
      final url = Uri.parse(
        "${Urls.baseUrl}/conversations/$chatId/send_message/",
      );

      final response = await http.post(
        url,
        headers: {
          "Authorization": "JWT $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"title": userMessage}),
      );

      // Stop dot animation
      keepLoading = false;
      await loader;

      if (kDebugMode) {
        print("✅ Message sent: $userMessage");
        print("🧠 Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final aiResponse = data["AI"] ?? "No response";

        // Typing effect
        final buffer = StringBuffer();
        for (int i = 0; i < aiResponse.length; i++) {
          await Future.delayed(const Duration(milliseconds: 5));
          buffer.write(aiResponse[i]);
          aiLoaderMsg.text = buffer.toString();
          chatMessages.refresh();
        }
      } else {
        aiLoaderMsg.text = "⚠️ Failed to get AI response.";
        chatMessages.refresh();
        Get.snackbar("Error", "Message failed to send.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong.");
      if (kDebugMode) print("❌ sendMessage error: $e");
    }
  }


}

class ChatMessage {
  String text; // ✅ Now mutable
  final ChatRole role;
  final ChatPosition chatPosition;

  ChatMessage({
    required this.text,
    required this.role,
    required this.chatPosition,
  });
}
