import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../network_caller/endpoints.dart';
import '../../../routes.dart';
import '../../../services_class/shared_preferences_helper.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    print("🔹 Trying login with Email: $email | Password: $password");

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter both email and password");
      return;
    }

    isLoading.value = true;

    try {
      final loginUrl = Uri.parse(Urls.login);
      final body = jsonEncode({"email": email, "password": password});

      print("🌍 Sending POST request to: $loginUrl");
      print("📤 Request Body: $body");

      final response = await http.post(
        loginUrl,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print("📥 Response Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = data["access"];
        final userId = data["user"]["id"].toString();

        print("✅ Login successful. Token: $token | UserID: $userId");

        await SharedPreferencesHelper.saveToken(token);
        await SharedPreferencesHelper.saveUserId(userId);

        Get.snackbar("Success", data["message"] ?? "Login successful");
        Get.offAllNamed(AppRoutes.onboard);
      } else {
        /// Special case: backend returns non_field_errors -> invalid credentials
        if (data is Map &&
            data.containsKey("message") &&
            data["message"].toString().contains(
              "User is not verified. Please verify your account.",
            )) {
          print(
            "⚠️ Invalid credentials, maybe unverified account → show dialog",
          );

          Get.defaultDialog(
            title: "Verify Account",
            middleText:
                "Your account may not be verified.\nDo you want to verify now?",
            textConfirm: "Verify",
            textCancel: "Cancel",
            confirmTextColor: Colors.black,
            onConfirm: () {
              Get.back(); // close dialog
              _sendOtp(email); // ✅ call OTP function
            },
            onCancel: () => Get.back(),
          );
        } else {
          print(
            "❌ Login failed. Message: ${data["message"] ?? data.toString()}",
          );
          Get.snackbar(
            "Login Failed",
            data["message"] ?? "Invalid credentials",
          );
        }
      }
    } catch (e) {
      print("⚠️ Exception during login: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      print("🔄 Loading finished");
    }
  }

  /// 🔹 Separate function to handle OTP sending
  Future<void> _sendOtp(String email) async {
    try {
      final otpUrl = Uri.parse(Urls.signupotp);
      final otpBody = jsonEncode({"email": email});

      print("📤 Sending OTP POST to: $otpUrl");
      print("📦 OTP body: $otpBody");

      final otpResponse = await http.post(
        otpUrl,
        headers: {'Content-Type': 'application/json'},
        body: otpBody,
      );

      print("✅ OTP response code: ${otpResponse.statusCode}");
      print("📨 OTP response body: ${otpResponse.body}");

      final otpData = jsonDecode(otpResponse.body);

      if (otpResponse.statusCode == 200 || otpResponse.statusCode == 201) {
        print("📲 OTP sent successfully, navigating to verifyOtp screen");
        Get.toNamed(AppRoutes.verifyOtp, arguments: {'email': email});
      } else {
        print("❌ OTP sending failed: ${otpData["message"]}");
        Get.snackbar("OTP Error", otpData["message"] ?? "Failed to send OTP");
      }
    } catch (e) {
      print("🔥 Exception while sending OTP: $e");
      Get.snackbar("Error", "Something went wrong while sending OTP: $e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
