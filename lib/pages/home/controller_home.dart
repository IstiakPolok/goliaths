part of '../_pages.dart';

/// ****************************************************************************
/// Controller for home section
/// ****************************************************************************
class ControllerHome extends GetxController {
  RxList<ChatMessage> chatMessages =
      [
        // First message from the user (top)
        ChatMessage(
          text:
              "Hey, I recently read a book called 'Breaking Goliath'. Have you heard of it?",
          role: ChatRole.user,
          chatPosition: ChatPosition.single,
        ),
        // AI response (middle)
        ChatMessage(
          text:
              "Yes, it's an inspiring book about overcoming giants and challenges. What did you think about it?",
          role: ChatRole.ai,
          chatPosition: ChatPosition.single,
        ),
        // Next message from the user (middle)
        ChatMessage(
          text:
              "I really liked how it used the metaphor of 'Goliath' to represent big obstacles. It made me think about my own struggles.",
          role: ChatRole.user,
          chatPosition: ChatPosition.single,
        ),
        // AI response (middle)
        ChatMessage(
          text:
              "Exactly! The story of David and Goliath is so powerful, especially when it’s applied to personal challenges.",
          role: ChatRole.ai,
          chatPosition: ChatPosition.single,
        ),
        // Next message from the user (bottom)
        ChatMessage(
          text:
              "The author really emphasizes that even the smallest person can overcome the biggest of obstacles.",
          role: ChatRole.user,
          chatPosition: ChatPosition.top,
        ),
        // Next message from the user (bottom)
        ChatMessage(
          text: "It's motivational.",
          role: ChatRole.user,
          chatPosition: ChatPosition.middle,
        ),
        // Next message from the user (bottom)
        ChatMessage(
          text: "Definitely?",
          role: ChatRole.user,
          chatPosition: ChatPosition.bottom,
        ),
        // Final AI response (bottom)
        ChatMessage(
          text:
              "Definitely. It's a reminder that courage and perseverance can take us farther than we think. Do you feel more motivated?",
          role: ChatRole.ai,
          chatPosition: ChatPosition.single,
        ),
      ].obs;
}

class ChatMessage {
  final String text;
  final ChatRole role;
  final ChatPosition chatPosition;

  ChatMessage({
    required this.text,
    required this.role,
    required this.chatPosition,
  });
}
