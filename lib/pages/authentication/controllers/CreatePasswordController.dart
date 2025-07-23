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
  //late String email;

  void initEmail(String userEmail) {
    email = userEmail;
  }

  Future<void> resetPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please fill all fields.");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    isLoading.value = true;
    final url = Uri.parse("${Urls.baseUrl}/auth/set-new-password/");

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

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          data["message"] ?? "Password reset successful ✅",
        );
        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to reset password ❌");
      }
    } catch (e) {
      Get.snackbar("Error", "Server error. Try again later.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
