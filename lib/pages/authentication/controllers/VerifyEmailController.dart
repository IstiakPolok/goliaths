import 'dart:convert';
import 'package:get/get.dart';
import 'package:goliaths/pages/_pages.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../services_class/shared_preferences_helper.dart'; // if you want to store anything
import '../../../network_caller/endpoints.dart'; // assuming baseUrl is defined here

class VerifyEmailController extends GetxController {
  final emailController = TextEditingController();
  var isLoading = false.obs;

  Future<void> sendResetOtp() async {
    final email = emailController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Please enter a valid email address 😐");
      return;
    }

    isLoading.value = true;

    final url = Uri.parse("${Urls.baseUrl}/auth/send-reset-otp/");
    print("🔄 Sending POST to: $url");
    print("📧 Email: $email");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      print("📬 Response Code: ${response.statusCode}");
      print("📬 Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "OTP sent to your email 📩");
        Get.off(
          () => const ScreenResetVerifyOtp(),
          arguments: {"email": email},
        );
      } else {
        Get.snackbar("Failed", data['message'] ?? "Something went wrong ❌");
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar("Error", "Server error. Please try again later 😓");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    super.onClose();
  }

  final otpController = TextEditingController();

  var userEmail = ''.obs; // holds the email passed from previous screen

  Future<void> submitOtp() async {
    final otp = otpController.text.trim();
    final email = userEmail.value;

    if (otp.isEmpty || otp.length < 4) {
      Get.snackbar("Error", "Please enter a valid OTP");
      return;
    }

    isLoading.value = true;
    final url = Uri.parse("${Urls.baseUrl}/auth/verify-reset-otp/");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", data["message"] ?? "OTP verified 🎉");
        Get.to(() => ScreenCreatePassword(email: email));

        // Navigate to reset password screen, maybe pass the email again
      } else {
        Get.snackbar("Failed", data["message"] ?? "Invalid OTP ❌");
      }
    } catch (e) {
      Get.snackbar("Error", "Server error. Try again later");
    } finally {
      isLoading.value = false;
    }
  }
}
