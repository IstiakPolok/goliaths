import 'dart:convert';
import 'package:Goliaths/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../network_caller/endpoints.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> registerUser() async {
    //final nameParts = fullNameController.text.trim().split(' ');
    // final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    // final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    print("📝 Starting registration...");
    print("📧 Email: ${emailController.text.trim()}");
    print("🔑 Password: ${passwordController.text.trim()}");
    print("👤 Full Name: ${fullNameController.text.trim()}");

    // final registerBody = jsonEncode({
    //   "email": emailController.text.trim(),
    //   "password": passwordController.text.trim(),
    //   "input_full_name": fullNameController.text.trim(), // ✅ use .text
    // });

    if (passwordController.text != confirmPasswordController.text) {
      print("❌ Passwords do not match");
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;

    try {
      final registerUrl = Uri.parse(Urls.signup);
      print("📤 Sending registration POST to: $registerUrl");

      final registerBody = jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "input_full_name": fullNameController.text.trim(),
      });

      print("📦 Register body: $registerBody");

      final registerResponse = await http.post(
        registerUrl,
        headers: {'Content-Type': 'application/json'},
        body: registerBody,
      );

      print("✅ Register response code: ${registerResponse.statusCode}");
      print("📨 Register response body: ${registerResponse.body}");

      final registerData = jsonDecode(registerResponse.body);

      if (registerResponse.statusCode == 200 ||
          registerResponse.statusCode == 201) {
        print("🎉 Registration successful");

        Get.snackbar(
          "Success",
          registerData["message"] ?? "User registered successfully",
        );

        /// 🔁 Call the send-verification-otp API
        final otpUrl = Uri.parse(Urls.signupotp);
        print("📤 Sending OTP POST to: $otpUrl");

        final otpBody = jsonEncode({"email": emailController.text.trim()});
        print("📦 OTP body: $otpBody");

        final otpResponse = await http.post(
          otpUrl,
          headers: {'Content-Type': 'application/json'},
          body: otpBody,
        );

        print("✅ OTP response code: ${otpResponse.statusCode}");
        print("📨 OTP response body: ${otpResponse.body}");

        //final otpData = jsonDecode(otpResponse.body);

        if (registerResponse.statusCode == 200 ||
            registerResponse.statusCode == 201) {
          print("🎉 Registration successful");

          Get.snackbar(
            "Success",
            registerData["message"] ?? "User registered successfully",
          );

          /// 🔁 Call the send-verification-otp API
          final otpUrl = Uri.parse(Urls.signupotp);
          print("📤 Sending OTP POST to: $otpUrl");

          final otpBody = jsonEncode({"email": emailController.text.trim()});
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
            Get.toNamed(
              AppRoutes.verifyOtp,
              arguments: {'email': emailController.text.trim()},
            );
          } else {
            print("❌ OTP sending failed: ${otpData["message"]}");
            Get.snackbar(
              "OTP Error",
              otpData["message"] ?? "Failed to send OTP",
            );
          }
        }
      } else {
        /// ✅ Handle validation errors from backend
        print("❌ Registration failed with validation errors: $registerData");

        // Convert the error messages into a readable string
        String errorMsg = "";
        registerData.forEach((key, value) {
          if (value is List) {
            errorMsg += "$key: ${value.join(', ')}\n";
          } else {
            errorMsg += "$key: $value\n";
          }
        });

        Get.snackbar("Registration Failed", errorMsg.trim());
      }
    } catch (e) {
      print("🔥 Exception during registration: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      print("✅ Done with registration process");
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
