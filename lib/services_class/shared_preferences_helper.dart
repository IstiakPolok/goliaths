import 'dart:convert';

import 'package:get/get.dart';
import 'package:goliaths/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/_pages.dart';

class SharedPreferencesHelper {
  static const String _accessTokenKey = 'token';
  static const String _selectedRoleKey = 'selectedRole';
  static const String _categoriesKey = "categories";
  static const String _isWelcomeDialogShownKey =
      'isDriverVerificationDialogShown';
  static const String _subscriptionIdKey = 'subscriptionId';
  static const String _selectedAiModeKey = 'selectedAiMode';

  // Save categories (id and name only)
  static Future<void> saveCategories(
    List<Map<String, String>> categories,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final categoriesJson = jsonEncode(categories);
    await prefs.setString(_categoriesKey, categoriesJson);
  }

  // Retrieve categories (id and name only)
  static Future<List<Map<String, String>>> getCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final categoriesJson = prefs.getString(_categoriesKey);
    if (categoriesJson != null) {
      return List<Map<String, String>>.from(jsonDecode(categoriesJson));
    }
    return [];
  }



  static Future<void> saveSubscriptionId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_subscriptionIdKey, id);
    print("✅ Subscription ID saved: $id");
  }

  static Future<int?> getSubscriptionId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_subscriptionIdKey);
  }

  // Save access token
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setBool('isLogin', true);
    print("Token saved: $token");
  }

  // Retrieve access token
  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Clear access token
  static Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored keys and values
    print("✅ All shared preferences cleared.");
  }


  // Retrieve selected role
  static Future<String?> getSelectedRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedRoleKey);
  }

  static Future<bool?> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  // Save the flag indicating the dialog has been shown
  static Future<void> setWelcomeDialogShown(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isWelcomeDialogShownKey, value);
  }

  // Retrieve the flag to check if the dialog has been shown
  static Future<bool> isWelcomeDialogShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isWelcomeDialogShownKey) ?? false;
  }

  // Key for showOnboard
  static const String _showOnboardKey = 'showOnboard';

  // Save the showOnboard flag
  static Future<void> setShowOnboard(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showOnboardKey, value);
  }

  // Retrieve the showOnboard flag
  static Future<bool> getShowOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showOnboardKey) ??
        false; // Default to false if not set
  }

  static Future<void> logoutUser() async {
    await clearAllData(); // clears all preferences
    Get.offAllNamed(AppRoutes.login);
  }


  static const String _userIdKey = 'userId';

  // Save only the user ID
  static Future<void> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    print("User ID saved: $userId");
  }

  // Retrieve the user ID
  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }
  

  static Future<void> saveSelectedAiMode(String mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedAiModeKey, mode);
    print("🧠 AI Mode saved: $mode");
  }

// Retrieve selected AI mode
  static Future<String?> getSelectedAiMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedAiModeKey);
  }
}
