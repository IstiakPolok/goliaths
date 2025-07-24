import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../network_caller/endpoints.dart';
import '../../../routes.dart';

class CreatePasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  late String email;

  void initEmail(String userEmail) {
    email = userEmail;
    print("📧 Initialized email: $email");
  }

  Future<void> resetPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    print("🔐 Password: $password");
    print("🔐 Confirm Password: $confirmPassword");

    if (password.isEmpty || confirmPassword.isEmpty) {
      print("❌ One or both fields are empty.");
      Get.snackbar("Error", "Please fill all fields.");
      return;
    }

    if (password != confirmPassword) {
      print("❌ Passwords do not match.");
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    isLoading.value = true;
    final url = Uri.parse("${Urls.baseUrl}/auth/set-new-password/");
    print("📡 Sending POST request to $url");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "new_password": password,
          "confirm_password": confirmPassword,
        }),
      );

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("✅ Password reset successful.");
        Get.snackbar(
          "Success",
          data["message"] ?? "Password reset successful ✅",
        );
        Get.offAllNamed(AppRoutes.passChangeSuccess);
      } else {
        print("❌ Failed to reset password. Message: ${data["message"]}");
        Get.snackbar("Error", data["message"] ?? "Failed to reset password ❌");
      }
    } catch (e) {
      print("⚠️ Exception during password reset: $e");
      Get.snackbar("Error", "Server error. Try again later.");
    } finally {
      isLoading.value = false;
      print("🔄 Loading state reset to false");
    }
  }

  @override
  void onClose() {
    print("🧹 Disposing controllers...");
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
