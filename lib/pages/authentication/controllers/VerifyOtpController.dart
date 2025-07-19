import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../network_caller/endpoints.dart';
import '../../../routes.dart';

class VerifyOtpController extends GetxController {
  final otpController = TextEditingController();
  final isLoading = false.obs;

  late final String email; // assigned from arguments

  @override
  void onInit() {
    super.onInit();
    // Get the email from previous screen arguments
    email = Get.arguments?['email'] ?? '';
    print("📧 Email passed to OTP screen: $email");
  }

  Future<void> submitOtp() async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      Get.snackbar("Error", "Please enter the OTP");
      return;
    }

    isLoading.value = true;
    try {
      final url = Uri.parse(Urls.signupotpverify);
      print("📤 Sending OTP verification request to $url");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      print("✅ Response Code: ${response.statusCode}");
      print("📨 Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", data["message"] ?? "Account verified");
        Get.toNamed(AppRoutes.createPass);
      } else {
        Get.snackbar("Failed", data["message"] ?? "Invalid OTP or email");
      }
    } catch (e) {
      print("🔥 Exception during OTP verification: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
