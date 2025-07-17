part of '../_models.dart';

class GoliathsTheme {
  final Color primary;
  final Color onPrimary;
  final Color accent;
  final Color background;
  final Color onBackground;
  final Color text;
  final Color chatBubble1;
  final Color chatBubble2;
  final Color onChatBubble1;
  final Color onChatBubble2;
  final Color textOnPrimary;
  final Color stroke;
  final Color barIcon;
  final Color inputBackground;

  GoliathsTheme({
    required this.primary,
    required this.onPrimary,
    required this.accent,
    required this.background,
    required this.onBackground,
    required this.text,
    required this.textOnPrimary,
    required this.chatBubble1,
    required this.chatBubble2,
    required this.onChatBubble1,
    required this.onChatBubble2,
    required this.stroke,
    required this.barIcon,
    required this.inputBackground,
  });
}

class GoliathsTypoGraphy {
  final TextStyle screenHeading;
  final TextStyle screenTitle;
  final TextStyle screenText;
  final TextStyle button;

  GoliathsTypoGraphy({
    required this.screenHeading,
    required this.screenTitle,
    required this.screenText,
    required this.button,
  });
}
