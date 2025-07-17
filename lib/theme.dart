import 'dart:ui';

import 'package:flutter/material.dart'
    show
        BuildContext,
        ButtonTextTheme,
        ButtonThemeData,
        CardTheme,
        ColorScheme,
        Colors,
        IconThemeData,
        TextStyle,
        TextTheme,
        ThemeData,
        CardThemeData;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goliaths/model/_models.dart';

final goliathsTheme = GoliathsTheme(
  primary: Color(0xFF302E2E),
  onPrimary: Color(0xFF1E1C1C),
  chatBubble1: Color(0xFF1E1C1C),
  onChatBubble1: Color(0xFFFFFFFF),
  chatBubble2: Color(0xFFF4F7FD),
  onChatBubble2: Color(0xFF1E1C1C),
  accent: Color(0xFFF9BE2D),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF1E1C1C),
  inputBackground: Color(0xFFDADADA),
  text: Color(0xFF1E1C1C),
  barIcon: Color(0xFF6E6E6E),
  textOnPrimary: Color(0xFFFFFFFF),
  stroke: Color(0xFFF2F2F2),
);

final goliathsTypography = GoliathsTypoGraphy(
  screenHeading: TextStyle(
    color: goliathsTheme.accent,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "Poly",
  ),
  screenTitle: TextStyle(
    color: goliathsTheme.text,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontFamily: "Poly",
  ),
  screenText: TextStyle(
    color: goliathsTheme.text,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    fontFamily: "Poly",
  ),
  button: TextStyle(
    color: goliathsTheme.text,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "Poly",
  ),
);

ThemeData createGoliathsTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: goliathsTheme.background,
    textTheme: TextTheme(),
    iconTheme: IconThemeData(color: goliathsTheme.text),
    buttonTheme: ButtonThemeData(
      buttonColor: goliathsTheme.accent,
      textTheme: ButtonTextTheme.primary,
    ),
    // Define custom styles for chat bubbles
    cardColor: goliathsTheme.chatBubble1,
    cardTheme: CardThemeData(
      color: goliathsTheme.chatBubble1,
      shadowColor: goliathsTheme.chatBubble2,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      // Set the brightness to light or dark as per requirement
      primary: goliathsTheme.primary,
      onPrimary: goliathsTheme.onPrimary,
      secondary: goliathsTheme.accent,
      onSecondary: goliathsTheme.onBackground,
      // On secondary could be the text color on accents
      error: Colors.red,
      // You can customize the error color as well
      onError: Colors.white,
      // Customize onError color
      surface: goliathsTheme.background,
      onSurface: goliathsTheme.text,
    ).copyWith(background: goliathsTheme.background),
    // You can extend this to more custom widgets and properties as needed
  );
}
